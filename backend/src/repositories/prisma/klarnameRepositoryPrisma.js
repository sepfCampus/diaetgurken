const prisma = require("../../db/prismaClient");

async function findByKlientenAkteId(klientenAkteId) {
    return prisma.klarname.findUnique({
        where: { klientenAkteId },
    });
}

async function upsert(klientenAkteId, name) {
    return prisma.klarname.upsert({
        where: { klientenAkteId },
        update: { name },
        create: {
            klientenAkteId,
            name,
        },
    });
}

module.exports = {
    findByKlientenAkteId,
    upsert,
};