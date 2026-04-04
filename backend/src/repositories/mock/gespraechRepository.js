const gespraeche = [];
let currentId = 1;

function findById(id) {
    return gespraeche.find(g => g.id === id)
        || null;
}

function findByKlientenAkteId(klientenAkteId) {
    return gespraeche.filter(g => g.klientenAkteId === klientenAkteId);
}

function deleteById(id) {
    const index = gespraeche.findIndex((gespraech) => gespraech.id === id);

    if (index === -1) {
        return false;
    }

    gespraeche.splice(index, 1);
    return true;
}

function create(data) {
    const neuesGespraech = {
        id: currentId++,
        ...data,
    };
    gespraeche.push(neuesGespraech);
    return neuesGespraech;
}

function updateById(id, updatedData) {
    const gespraech = findById(id);
    if (!gespraech) {
        return null;
    }
    Object.assign(gespraech, updatedData);
    return gespraech;
}

module.exports = {
    findById,
    findByKlientenAkteId,
    deleteById,
    create,
    updateById,
};

