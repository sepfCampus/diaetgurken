const einstellungen = [];

function findByUserId(userId) {
    return einstellungen.find(
        (eintrag) => eintrag.userId === userId
    ) || null;
}

function upsert(data) {
    const existing = findByUserId(data.userId);

    if (existing) {
        existing.farbdarstellung = data.farbdarstellung;
        existing.schriftgroesse = data.schriftgroesse;
        return existing;
    }

    einstellungen.push(data);
    return data;
}

module.exports = {
    findByUserId,
    upsert,
};