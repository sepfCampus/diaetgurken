const klientenAkteRepository = require("../repositories/mock/klientenAkteRepository");
const ApiError = require("../utils/ApiError");

function getAllForCurrentUser(session) {
    if (!session?.userId) {
        throw new ApiError(401, "Nicht eingeloggt");
    }

    return klientenAkteRepository.findByUserId(session.userId);
}

function createForCurrentUser(session) {
    if (!session?.userId) {
        throw new ApiError(401, "Nicht eingeloggt");
    }

    return klientenAkteRepository.create(session.userId);
}

function deleteForCurrentUser(akteId, session) {
    if (!session?.userId) {
        throw new ApiError(401, "Nicht eingeloggt");
    }

    const akte = klientenAkteRepository.findById(Number(akteId));

    if (!akte) {
        throw new ApiError(404, "Klientenakte nicht gefunden");
    }

    if (akte.userId !== session.userId) {
        throw new ApiError(403, "Kein Zugriff auf diese Klientenakte");
    }

    klientenAkteRepository.deleteById(akte.id);
}

module.exports = {
    getAllForCurrentUser,
    createForCurrentUser,
    deleteForCurrentUser,
};