const pdfExportService = require("../services/pdfExportService");

async function exportGespräch(req, res, next) {
    try {
        const pdfBuffer = await pdfExportService.createGesprächPdf(
            req.params.gespraechId,
            req.session
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

module.exports = {
    exportGespräch,
};