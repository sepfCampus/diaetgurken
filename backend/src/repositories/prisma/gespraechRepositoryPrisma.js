const prisma = require("../../db/prismaClient");

async function findByAkteId(klientenAkteId) {
    return prisma.gespraech.findMany({
        where: { klientenAkteId },
        orderBy: { datum: "desc" },
    });
}

async function findById(id) {
    return prisma.gespraech.findUnique({
        where: { id },
    });
}

async function create(klientenAkteId, data) {
    return prisma.gespraech.create({
        data: {
            klientenAkteId,
            datum: data.datum ? new Date(data.datum) : undefined,
            formMetaData: data.formMetaData ? JSON.stringify(data.formMetaData) : null,
            assessment: data.assessment ? JSON.stringify(data.assessment) : null,
            diagnosen: data.diagnosen ? JSON.stringify(data.diagnosen) : null,
            ziele: data.ziele ? JSON.stringify(data.ziele) : null,
            outcome: data.outcome ? JSON.stringify(data.outcome) : null,
            notizen: data.notizen ?? null,
        },
    });
}

async function updateById(id, klientenAkteId, data) {
    return prisma.gespraech.update({
        where: { id },
        data: {
            klientenAkteId,
            datum: data.datum ? new Date(data.datum) : undefined,
            formMetaData: data.formMetaData ? JSON.stringify(data.formMetaData) : null,
            assessment: data.assessment ? JSON.stringify(data.assessment) : null,
            diagnosen: data.diagnosen ? JSON.stringify(data.diagnosen) : null,
            ziele: data.ziele ? JSON.stringify(data.ziele) : null,
            outcome: data.outcome ? JSON.stringify(data.outcome) : null,
            notizen: data.notizen ?? null,
        },
    });
}

async function deleteById(id) {
    return prisma.gespraech.delete({
        where: { id },
    });
}

module.exports = {
    findByAkteId,
    findById,
    create,
    updateById,
    deleteById,
};