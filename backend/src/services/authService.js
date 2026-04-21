const userRepository = require("../repositories/prisma/userRepositoryPrisma");
const { hashPassword, comparePassword } = require("../utils/passwordUtil");
const ApiError = require("../utils/ApiError");

async function register({ email, password, registerNr }) {
    if (!email || !password || !registerNr) {
        throw new ApiError(400, "Email, Passwort und Registernummer sind erforderlich");
    }

    const existingEmail = await userRepository.findByEmail(email);
    if (existingEmail) {
        throw new ApiError(409, "E-Mail ist bereits registriert");
    }

    const existingRegisterNr = await userRepository.findByRegisterNr(registerNr);
    if (existingRegisterNr) {
        throw new ApiError(409, "Registernummer ist bereits registriert");
    }

    const passwordHash = await hashPassword(password);

    const user = await userRepository.create({
        email,
        registerNr,
        passwordHash,
    });

    return {
        id: user.id,
        email: user.email,
        registerNr: user.registerNr,
    };
}

async function login({ email, password }, session) {
    if (!email || !password) {
        throw new ApiError(400, "Email und Passwort sind erforderlich");
    }

    const user = await userRepository.findByEmail(email);
    if (!user) {
        throw new ApiError(401, "Ungültige Anmeldedaten");
    }

    const passwordMatches = await comparePassword(password, user.passwordHash);
    if (!passwordMatches) {
        throw new ApiError(401, "Ungültige Anmeldedaten");
    }

    session.userId = user.id;

    return {
        id: user.id,
        email: user.email,
        registerNr: user.registerNr,
    };
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

    return {
        id: user.id,
        email: user.email,
        registerNr: user.registerNr,
    };
}

module.exports = {
    register,
    login,
    logout,
    whoami,
};