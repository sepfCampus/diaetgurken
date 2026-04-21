const prisma = require("../../db/prismaClient");

async function findByUserId(userId) {
    return prisma.einstellungen.findUnique({
        where: { userId },
    });
}

async function upsert(userId, farbdarstellung, schriftgroesse) {
    return prisma.einstellungen.upsert({
        where: { userId },
        update: { farbdarstellung, schriftgroesse },
        create: { userId, farbdarstellung, schriftgroesse },
    });
}

module.exports = {
    findByUserId,
    upsert,
};