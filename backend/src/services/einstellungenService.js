const einstellungenRepository = require('../repositories/mock/einstellungenRepository');
const ApiError = require('../utils/ApiError');

function getforCurrentUser(session) {
    if (!session?.userId) {
        throw new ApiError(401, 'Nicht eingeloggt');
    }

    const existing = einstellungenRepository.findByUserId(session.userId);

    if (existing) {
        return existing;
    }

    return {
        userId: session.userId,
        farbdarstellung: "standard",
        schriftgroesse: "mittel",
    };
}

function updateEinstellungen({ farbdarstellung, schriftgroesse }, session) {
    if (!session?.userId) {
        throw new ApiError(401, 'Nicht eingeloggt');
    }

    if (!farbdarstellung || !schriftgroesse) {
        throw new ApiError(400, 'Farbdarstellung und Schriftgröße sind erforderlich');
    }

    return einstellungenRepository.upsert({
        userId: session.userId,
        farbdarstellung: farbdarstellung,
        schriftgroesse: schriftgroesse,
    });
}

module.exports = {
    getforCurrentUser,
    updateEinstellungen,
};