const prisma = require("../../db/prismaClient");

async function findByUserId(userId) {
    return prisma.klientenAkte.findMany({
        where: { userId },
    });
}

async function findById(id) {
    return prisma.klientenAkte.findUnique({
        where: { id },
        include: { klarname: true },
    });
}

async function findOwnerById(id) {
    return prisma.klientenAkte.findUnique({
        where: { id },
        select: { id: true, userId: true },
    });
}

async function create(userId) {
    return prisma.klientenAkte.create({
        data: { userId },
    });
}

async function deleteById(id) {
    return prisma.klientenAkte.delete({
        where: { id },
    });
}

module.exports = {
    findByUserId,
    findById,
    findOwnerById,
    create,
    deleteById,
};
