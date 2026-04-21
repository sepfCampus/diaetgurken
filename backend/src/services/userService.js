const userRepository = require("../repositories/prisma/userRepositoryPrisma");
const { hashPassword } = require("../utils/passwordUtil");
const ApiError = require("../utils/ApiError");

async function deleteCurrentUser(session) {
    if (!session?.userId) {
        throw new ApiError(401, "Nicht eingeloggt");
    }

    const currentUser = await userRepository.findById(session.userId);
    if (!currentUser) {
        throw new ApiError(404, "Benutzer nicht gefunden");
    }

    await userRepository.deleteById(session.userId);
}

async function updateCurrentUser({ email, password, registerNr }, session) {
    if (!session?.userId) {
        throw new ApiError(401, "Nicht eingeloggt");
    }

    if (!email || !password || !registerNr) {
        throw new ApiError(400, "Email, Passwort und Registriernummer sind erforderlich");
    }

    const currentUser = await userRepository.findById(session.userId);
    if (!currentUser) {
        throw new ApiError(404, "Benutzer nicht gefunden");
    }

    const userWithSameEmail = await userRepository.findByEmail(email);
    if (userWithSameEmail && userWithSameEmail.id !== session.userId) {
        throw new ApiError(409, "Email ist bereits vergeben");
    }

    const userWithSameRegisterNr = await userRepository.findByRegisterNr(registerNr);
    if (userWithSameRegisterNr && userWithSameRegisterNr.id !== session.userId) {
        throw new ApiError(409, "Registriernummer ist bereits vergeben");
    }

    const passwordHash = await hashPassword(password);

    const updatedUser = await userRepository.updateById(session.userId, {
        email,
        registerNr,
        passwordHash,
    });

    return {
        id: updatedUser.id,
        email: updatedUser.email,
        registerNr: updatedUser.registerNr,
    };
}

module.exports = {
    deleteCurrentUser,
    updateCurrentUser,
};