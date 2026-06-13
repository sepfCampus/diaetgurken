const userRepository = require("../repositories/prisma/userRepositoryPrisma");
const einstellungenRepository = require("../repositories/prisma/einstellungenRepositoryPrisma");
const { hashPassword, comparePassword } = require("../utils/passwordUtil");
const ApiError = require("../utils/ApiError");

async function register({ email, passwort, registerNr }) {
    if (!email || !passwort || !registerNr) {
        throw new ApiError(400, "Email, Passwort und Registernummer sind erforderlich");
    }

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
        throw new ApiError(400, "Ungültige E-Mail-Adresse");
    }

    if (passwort.length < 6) {
        throw new ApiError(400, "Passwort muss mindestens 6 Zeichen lang sein");
    }

    if (registerNr.trim().length === 0) {
        throw new ApiError(400, "Registernummer darf nicht leer sein");
    }

    const existingEmail = await userRepository.findByEmail(email);
    if (existingEmail) {
        throw new ApiError(409, "E-Mail ist bereits registriert");
    }

    const existingRegisterNr = await userRepository.findByRegisterNr(registerNr);
    if (existingRegisterNr) {
        throw new ApiError(409, "Registernummer ist bereits registriert");
    }

    const passwordHash = await hashPassword(passwort);
    const user = await userRepository.create({ email, registerNr, passwordHash });

    // Create default settings for the new user
    await einstellungenRepository.upsert(user.id, "standard", "standard");

    return { id: user.id, email: user.email, registerNr: user.registerNr };
}

async function login({ email, passwort, registerNr }, session) {
    if (!email || !passwort || !registerNr) {
        throw new ApiError(400, "Email, Passwort und Registernummer sind erforderlich");
    }

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
        throw new ApiError(400, "Ungültige E-Mail-Adresse");
    }

    const user = await userRepository.findByEmail(email);
    if (!user) {
        throw new ApiError(401, "Ungültige Anmeldedaten");
    }

    if (user.registerNr !== registerNr) {
        throw new ApiError(401, "Ungültige Anmeldedaten");
    }

    const passwortMatches = await comparePassword(passwort, user.passwordHash);
    if (!passwortMatches) {
        throw new ApiError(401, "Ungültige Anmeldedaten");
    }

    session.userId = user.id;

    return { id: user.id, email: user.email, registerNr: user.registerNr };
}

async function logout(session) {
    return new Promise((resolve, reject) => {
        session.destroy((err) => {
            if (err) {
                reject(new ApiError(500, "Logout fehlgeschlagen"));
            } else {
                resolve();
            }
        });
    });
}

async function whoami(session) {
    if (!session?.userId) {
        throw new ApiError(401, "Nicht eingeloggt");
    }

    const user = await userRepository.findById(session.userId);
    if (!user) {
        throw new ApiError(404, "Benutzer nicht gefunden");
    }

    return { id: user.id, email: user.email, registerNr: user.registerNr };
}

module.exports = {
    register,
    login,
    logout,
    whoami,
};