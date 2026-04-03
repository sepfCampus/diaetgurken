const klarnamen = [];

function findByKlientenAkteId(klientenAkteId) {
    return klarnamen.find(
        (eintrag) => eintrag.klientenAkteId === klientenAkteId
    ) || null;
}

function upsert(data) {
    const existing = findByKlientenAkteId(data.klientenAkteId);

    if (existing) {
        existing.name = data.name;
        return existing;
    }

    klarnamen.push(data);
    return data;
}

module.exports = {
    findByKlientenAkteId,
    upsert,
};