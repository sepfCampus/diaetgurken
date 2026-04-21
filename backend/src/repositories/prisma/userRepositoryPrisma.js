const prisma = require("../../db/prismaClient");

async function findByEmail(email) {
    return prisma.user.findUnique({
        where: { email },
    });
}

async function findByRegisterNr(registerNr) {
    return prisma.user.findUnique({
        where: { registerNr },
    });
}

async function findById(id) {
    return prisma.user.findUnique({
        where: { id },
    });
}

async function create(userData) {
    return prisma.user.create({
        data: userData,
    });
}

async function updateById(id, updatedData) {
    return prisma.user.update({
        where: { id },
        data: updatedData,
    });
}

async function deleteById(id) {
    return prisma.user.delete({
        where: { id },
    });
}

module.exports = {
    findByEmail,
    findByRegisterNr,
    findById,
    create,
    updateById,
    deleteById,
};
