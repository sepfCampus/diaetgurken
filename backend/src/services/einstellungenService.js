const einstellungenRepository = require('../repositories/prisma/einstellungenRepositoryPrisma');
const ApiError = require('../utils/ApiError');

async function getforCurrentUser(session) {
    if (!session?.userId) {
        throw new ApiError(401, 'Nicht eingeloggt');
    }

    const existing = await einstellungenRepository.findByUserId(session.userId);

    if (existing) {
        return existing;
    }

    return {
        userId: session.userId,
        farbdarstellung: "standard",
        schriftgroesse: "mittel",
    };
}

async function updateEinstellungen({ farbdarstellung, schriftgroesse }, session) {
    if (!session?.userId) {
        throw new ApiError(401, 'Nicht eingeloggt');
    }

    if (!farbdarstellung || !schriftgroesse) {
        throw new ApiError(400, 'Farbdarstellung und Schriftgröße sind erforderlich');
    }

    return await einstellungenRepository.upsert(
        session.userId,
        farbdarstellung,
        schriftgroesse,
    );
}

module.exports = {
    getforCurrentUser,
    updateEinstellungen,
};