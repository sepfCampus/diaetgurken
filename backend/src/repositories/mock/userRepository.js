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

module.exports = {
    findByEmail,
    findByRegisterNr,
    findById,
    create,
};