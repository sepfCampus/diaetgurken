const klientenAkteRepository = require("../repositories/prisma/klientenAkteRepositoryPrisma");
const ApiError = require("../utils/ApiError");

async function getAllForCurrentUser(session) {
    if (!session?.userId) {
        throw new ApiError(401, "Nicht eingeloggt");
    }

    return await klientenAkteRepository.findByUserId(session.userId);
}

async function createForCurrentUser(session) {
    if (!session?.userId) {
        throw new ApiError(401, "Nicht eingeloggt");
    }

    return await klientenAkteRepository.create(session.userId);
}

async function deleteForCurrentUser(akteId, session) {
    if (!session?.userId) {
        throw new ApiError(401, "Nicht eingeloggt");
    }

    const akte = await klientenAkteRepository.findById(Number(akteId));

    if (!akte) {
        throw new ApiError(404, "Klientenakte nicht gefunden");
    }

    if (akte.userId !== session.userId) {
        throw new ApiError(403, "Kein Zugriff auf diese Klientenakte");
    }

    await klientenAkteRepository.deleteById(akte.id);
}

module.exports = {
    getAllForCurrentUser,
    createForCurrentUser,
    deleteForCurrentUser,
};