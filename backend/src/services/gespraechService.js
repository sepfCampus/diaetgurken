const gespraechRepository = require("../repositories/prisma/gespraechRepositoryPrisma");
const klientenAkteRepository = require("../repositories/prisma/klientenAkteRepositoryPrisma");
const ApiError = require("../utils/ApiError");

async function getAllForKlientenAkte(klientenAkteId, session) {
    if (!session?.userId) {
        throw new ApiError(401, "Nicht eingeloggt");
    }

    const klientenAkte = await klientenAkteRepository.findById(Number(klientenAkteId));
    if (!klientenAkte) {
        throw new ApiError(404, "Klientenakte nicht gefunden");
    }

    if (klientenAkte.userId !== session.userId) {
        throw new ApiError(403, "Kein Zugriff auf diese Klientenakte");
    }

    return await gespraechRepository.findByAkteId(Number(klientenAkteId));
}

async function createForCurrentUser(data, session) {
    if (!session?.userId) {
        throw new ApiError(401, "Nicht eingeloggt");
    }

    const klientenAkteId = Number(data.klientenAkteId);

    if (!klientenAkteId || !data.datum) {
        throw new ApiError(400, "KlientenAkteId und Datum sind erforderlich");
    }

    const klientenAkte = await klientenAkteRepository.findById(klientenAkteId);
    if (!klientenAkte) {
        throw new ApiError(404, "Klientenakte nicht gefunden");
    }

    if (klientenAkte.userId !== session.userId) {
        throw new ApiError(403, "Kein Zugriff auf diese Klientenakte");
    }

    return await gespraechRepository.create(klientenAkteId, data);
}

async function updateForCurrentUser(data, session) {
    if (!session?.userId) {
        throw new ApiError(401, "Nicht eingeloggt");
    }

    const gespraechId = Number(data.id);
    const klientenAkteId = Number(data.klientenAkteId);

    if (!gespraechId || !klientenAkteId || !data.datum) {
        throw new ApiError(400, "Id, KlientenAkteId und Datum sind erforderlich");
    }

    const gespraech = await gespraechRepository.findById(gespraechId);
    if (!gespraech) {
        throw new ApiError(404, "Gespräch nicht gefunden");
    }

    const klientenAkte = await klientenAkteRepository.findById(klientenAkteId);
    if (!klientenAkte) {
        throw new ApiError(404, "Klientenakte nicht gefunden");
    }

    if (klientenAkte.userId !== session.userId) {
        throw new ApiError(403, "Kein Zugriff auf diese Klientenakte");
    }

    return await gespraechRepository.updateById(gespraechId, klientenAkteId, data);
}

async function deleteForCurrentUser(id, session) {
    if (!session?.userId) {
        throw new ApiError(401, "Nicht eingeloggt");
    }

    const gespraech = await gespraechRepository.findById(Number(id));
    if (!gespraech) {
        throw new ApiError(404, "Gespräch nicht gefunden");
    }

    const klientenAkte = await klientenAkteRepository.findById(Number(gespraech.klientenAkteId));
    if (!klientenAkte) {
        throw new ApiError(404, "Klientenakte nicht gefunden");
    }

    if (klientenAkte.userId !== session.userId) {
        throw new ApiError(403, "Kein Zugriff auf dieses Gespräch");
    }

    await gespraechRepository.deleteById(Number(id));
}

module.exports = {
    getAllForKlientenAkte,
    createForCurrentUser,
    updateForCurrentUser,
    deleteForCurrentUser,
};