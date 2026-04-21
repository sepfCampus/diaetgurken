const klientenAkten = [];
let currentId = 1;

function findByUserId(userId) {
    return klientenAkten.filter((akte) => akte.userId === userId);
}

function findById(id) {
    return klientenAkten.find((akte) => akte.id === id) || null;
}

function create(userId) {
    const newAkte = {
        id: currentId++,
        userId,
    };

    klientenAkten.push(newAkte);
    return newAkte;
}

function deleteById(id) {
    const index = klientenAkten.findIndex((akte) => akte.id === id);
    if (index === -1) {
        return false;
    }

    klientenAkten.splice(index, 1);
    return true;
}

module.exports = {
    findByUserId,
    findById,
    create,
    deleteById,
};