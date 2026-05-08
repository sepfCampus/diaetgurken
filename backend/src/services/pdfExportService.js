const klientenAkteRepository = require("../repositories/prisma/klientenAkteRepositoryPrisma");
const gespraechRepository = require("../repositories/prisma/gespraechRepositoryPrisma");
const ApiError = require("../utils/ApiError");
const pdfGenerator = require("../utils/pdfGenerator");

async function createGesprächPdf(gespraechId, session) {
    if (!session?.userId) {
        throw new ApiError(401, "Nicht eingeloggt");
    }

    const id = Number(gespraechId);

    const gespraech = await gespraechRepository.findById(id);

    if (!gespraech) {
        throw new ApiError(404, "Gespräch nicht gefunden");
    }

    const akte = await klientenAkteRepository.findById(gespraech.klientenAkteId);
    if (!akte || akte.userId !== session.userId) {
        throw new ApiError(403, "Kein Zugriff auf dieses Gespräch");
    }

    if (typeof pdfGenerator.generatePdfFromTemplate !== "function") {
        throw new ApiError(500, "PDF Generator nicht verfügbar");
    }

    return await pdfGenerator.generatePdfFromTemplate("gespraechPdf.ejs", {
        gespraech,
        akte,
        generatedAt: new Date(),
    });
}

module.exports = {
    createGesprächPdf,
};