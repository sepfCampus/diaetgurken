const pdfExportService = require("../services/pdfExportService");

async function exportGespräch(req, res, next) {
    try {
        const schriftgroesse = req.query.schriftgroesse || "standard";
        const kontrast = req.query.kontrast || "standard";
        const pdfBuffer = await pdfExportService.createGesprächPdf(
            req.params.gespraechId,
            req.session,
            schriftgroesse,
            kontrast
        );

        res.setHeader("Content-Type", "application/pdf");

        res.setHeader(
            "Content-Disposition",
            `attachment; filename="gespraech-${req.params.gespraechId}.pdf"`
        );

        res.send(pdfBuffer);
    } catch (err) {
        next(err);
    }
}

async function exportGesprächDocx(req, res, next) {
    try {
        const schriftgroesse = req.query.schriftgroesse || "standard";
        const kontrast = req.query.kontrast || "standard";
        const docxBuffer = await pdfExportService.createGesprächDocx(
            req.params.gespraechId,
            req.session,
            schriftgroesse,
            kontrast
        );

        res.setHeader("Content-Type", "application/vnd.openxmlformats-officedocument.wordprocessingml.document");

        res.setHeader(
            "Content-Disposition",
            `attachment; filename="gespraech-${req.params.gespraechId}.docx"`
        );

        res.send(docxBuffer);
    } catch (err) {
        next(err);
    }
}

module.exports = {
    exportGespräch,
    exportGesprächDocx,
};