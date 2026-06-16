const klientenAkteRepository = require("../repositories/prisma/klientenAkteRepositoryPrisma");
const gespraechRepository = require("../repositories/prisma/gespraechRepositoryPrisma");
const ApiError = require("../utils/ApiError");
const pdfGenerator = require("../utils/pdfGenerator");
const pdfColors = require("../config/pdfColors");

function getFontScale(schriftgroesse) {
    const scaleMap = {
        standard: 1,
        mittel: 1,
        gross: 1.6,
    };
    return scaleMap[schriftgroesse] || 1;
}

function getContrastColors(kontrast) {
    if (kontrast === "hoherKontrast") {
        return {
            ...pdfColors,
            PRIMARY: "#4d1e22",
            SECONDARY: "#968daf",
            TERTIARY: "#6b4c2f",
            QUATERNARY: "#0F4A74",
            BODY: "#FFFFFF",
            CARD_BACKGROUND: "#FFFFFF",
            PAGE_BACKGROUND: "#FFFFFF",
            TEXT: "#000000",
            MUTED_TEXT: "#222222",
            BORDER: "#000000",
        };
    }

    return pdfColors;
}

async function createGesprächPdf(gespraechId, session, schriftgroesse = "standard", kontrast = "standard") {
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

    const fontScale = getFontScale(schriftgroesse);
    const colors = getContrastColors(kontrast);

    if (typeof pdfGenerator.generatePdfFromTemplate !== "function") {
        throw new ApiError(500, "PDF Generator nicht verfügbar");
    }

    return await pdfGenerator.generatePdfFromTemplate("gespraechPdf_assessment.ejs", {
        gespraech,
        akte,
        generatedAt: new Date(),
        fontScale,
        colors,
    });
}

async function createGesprächDocx(gespraechId, session, schriftgroesse = "standard", kontrast = "standard") {
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

    const fontScale = getFontScale(schriftgroesse);
    const colors = getContrastColors(kontrast);

    if (typeof pdfGenerator.generateDocxFromTemplate !== "function") {
        throw new ApiError(500, "DOCX Generator nicht verfügbar");
    }

    console.log("[DOCX EXPORT] Verwende Template: gespraechDocx.ejs");

    return await pdfGenerator.generateDocxFromTemplate("gespraechDocx.ejs", {
        gespraech,
        akte,
        generatedAt: new Date(),
        fontScale,
        colors,
    });
}

module.exports = {
    createGesprächPdf,
    createGesprächDocx,
};