const gespraechRepository = require('../repositories/mock/gespraechRepository');
const ApiError = require('../utils/ApiError');
const klientenAktenRepository = require('../repositories/mock/klientenAkteRepository');

function getAllForKlientenAkte(klientenAktenId, session) {
    if (!session?.userId) {
        throw new ApiError(401, 'Nicht eingeloggt');
    }

    const klientenAkte = klientenAktenRepository.findById(Number(klientenAktenId));
    if (!klientenAkte) {
        throw new ApiError(404, 'Klientenakte nicht gefunden');
    }

    if (klientenAkte.userId !== session.userId) {
        throw new ApiError(403, 'Kein Zugriff auf diese Klientenakte');
    }

    return gespraechRepository.findByKlientenAkteId(Number(klientenAktenId));
}

function createForCurrentUser(data, session) {
    if (!session?.userId) {
        throw new ApiError(401, 'Nicht eingeloggt');
    }

    const {
        klientenAkteId,
        datum,
        formMetaData,
        assessment,
        diagnosen,
        ziele,
        outcome,
        notizen,
    } = data;

    if (!klientenAkteId || !datum) {
        throw new ApiError(400, 'KlientenAkteId und Datum sind erforderlich');
    }

    const klientenAkte = klientenAktenRepository.findById(klientenAkteId);
    if (!klientenAkte) {
        throw new ApiError(404, 'Klientenakte nicht gefunden');
    }

    if (klientenAkte.userId !== session.userId) {
        throw new ApiError(403, 'Kein Zugriff auf diese Klientenakte');
    }

    return gespraechRepository.create({
        klientenAkteId: Number(klientenAkteId),
        datum,
        formMetaData: formMetaData ?? null,
        assessment: assessment ?? null,
        diagnosen: diagnosen ?? null,
        ziele: ziele ?? null,
        outcome: outcome ?? null,
        notizen: notizen ?? null,
    });
}

function updateForCurrentUser(data, session) {
    if (!session?.userId) {
        throw new ApiError(401, 'Nicht eingeloggt');
    }

    const {
        id,
        klientenAkteId,
        datum,
        formMetaData,
        assessment,
        diagnosen,
        ziele,
        outcome,
        notizen,
    } = data;

    if (!id || !klientenAkteId || !datum) {
        throw new ApiError(400, 'ID, KlientenAkteId und Datum sind erforderlich');
    }

    const existingGespraech = gespraechRepository.findById(Number(id));
    if (!existingGespraech) {
        throw new ApiError(404, 'Gespraech nicht gefunden');
    }

    const klientenAkte = klientenAktenRepository.findById(Number(klientenAkteId));
    if (!klientenAkte) {
        throw new ApiError(404, 'Klientenakte nicht gefunden');
    }

    if (klientenAkte.userId !== session.userId) {
        throw new ApiError(403, 'Kein Zugriff auf diese Klientenakte');
    }

    return gespraechRepository.updateById(Number(id), {
        klientenAkteId: Number(klientenAkteId),
        datum,
        formMetaData: formMetaData ?? null,
        assessment: assessment ?? null,
        diagnosen: diagnosen ?? null,
        ziele: ziele ?? null,
        outcome: outcome ?? null,
        notizen: notizen ?? null,
    });
}

function deleteForCurrentUser(id, session) {
    if (!session?.userId) {
        throw new ApiError(401, 'Nicht eingeloggt');
    }

    const existingGespraech = gespraechRepository.findById(Number(id));
    if (!existingGespraech) {
        throw new ApiError(404, 'Gespraech nicht gefunden');
    }

    const klientenAkte = klientenAktenRepository.findById(existingGespraech.klientenAkteId);
    if (!klientenAkte) {
        throw new ApiError(404, 'Klientenakte nicht gefunden');
    }

    if (klientenAkte.userId !== session.userId) {
        throw new ApiError(403, 'Kein Zugriff auf diese Klientenakte');
    }

    return gespraechRepository.deleteById(Number(id));
}

module.exports = {
    getAllForKlientenAkte,
    createForCurrentUser,
    updateForCurrentUser,
    deleteForCurrentUser,
};