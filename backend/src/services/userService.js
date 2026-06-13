const userRepository = require("../repositories/prisma/userRepositoryPrisma");
const { hashPassword, comparePassword } = require("../utils/passwordUtil");
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

async function updateCurrentUser({ email, registerNr }, session) {
    if (!session?.userId) {
        throw new ApiError(401, "Nicht eingeloggt");
    }

    if (!email || !registerNr) {
        throw new ApiError(400, "Email und Registriernummer sind erforderlich");
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

    const updateData = {
        email,
        registerNr,
    };

    const updatedUser = await userRepository.updateById(session.userId, updateData);

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

async function changePassword(oldPassword, newPassword, session) {
    if (!session?.userId) {
        throw new ApiError(401, "Nicht eingeloggt");
    }

    if (!oldPassword || !newPassword) {
        throw new ApiError(400, "Altes und neues Passwort sind erforderlich");
    }

    const currentUser = await userRepository.findById(session.userId);
    if (!currentUser) {
        throw new ApiError(404, "Benutzer nicht gefunden");
    }

    const matches = await comparePassword(oldPassword, currentUser.passwordHash);
    if (!matches) {
        throw new ApiError(401, "Altes Passwort ist falsch");
    }

    const newHash = await hashPassword(newPassword);

    await userRepository.updateById(session.userId, { passwordHash: newHash });
}

module.exports = {
    deleteCurrentUser,
    updateCurrentUser,
    changePassword,
};