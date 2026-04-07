const users = [];
let currentId = 1;

function findByEmail(email) {
    return users.find((user) => user.email === email) || null;
}

function findByRegisterNr(registerNr) {
    return users.find((user) => user.registerNr === registerNr) || null;
}

function findById(id) {
    return users.find((user) => user.id === id) || null;
}

function create(userData) {
    const newUser = {
        id: currentId++,
        ...userData,
    };

    users.push(newUser);
    return newUser;
}

function updateById(id, updatedData) {
    const user = findById(id);
    if (!user) {
        return null;
    }
    Object.assign(user, updatedData);
    return user;
}

function deleteById(id) {
    const index = users.findIndex((user) => user.id === id);
    if (index === -1) {
        return false;
    }
    users.splice(index, 1);
    return true;
}

module.exports = {
    findByEmail,
    findByRegisterNr,
    findById,
    create,
    updateById,
    deleteById,
};