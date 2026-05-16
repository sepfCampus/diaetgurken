const fs = require("fs");
const path = require("path");
const ejs = require("ejs");
const puppeteer = require("puppeteer");
const htmlToDocx = require("html-to-docx");
const pdfColors = require("../config/pdfColors");

async function generatePdfFromTemplate(templateName, data) {
    const templatePath = path.join(__dirname, "..", "templates", templateName);
    const publicPath = path.join(__dirname, "..", "..", "public");
    const logoCandidates = [
        "logo.png",
        "logo.jpg",
        "logo.jpeg",
        "logo_diaetgurken.png",
        "logo_diaetgurken.jpg",
        "logo_diaetgurken.jpeg",
    ];

    let logoSrc = "";
    let logoMimeType = "image/png";

    for (const candidate of logoCandidates) {
        const candidatePath = path.join(publicPath, candidate);
        if (fs.existsSync(candidatePath)) {
            const imageData = fs.readFileSync(candidatePath);
            logoMimeType = candidate.endsWith(".jpg") || candidate.endsWith(".jpeg") ? "image/jpeg" : "image/png";
            logoSrc = `data:${logoMimeType};base64,${imageData.toString("base64")}`;
            break;
        }
    }

    const html = await ejs.renderFile(templatePath, {
        ...data,
        logoSrc,
        colors: data.colors || pdfColors,
    });

    const browser = await puppeteer.launch({
        headless: "new",
        args: ["--no-sandbox", "--disable-setuid-sandbox"],
    });

    try {
        const page = await browser.newPage();

        await page.setContent(html, {
            waitUntil: "networkidle0",
        });

        return await page.pdf({
            format: "A4",
            printBackground: true,
            margin: {
                top: "20mm",
                right: "15mm",
                bottom: "20mm",
                left: "15mm",
            },
        });
    } finally {
        await browser.close();
    }
}

async function generateDocxFromTemplate(templateName, data) {
    const templatePath = path.join(__dirname, "..", "templates", templateName);
    const publicPath = path.join(__dirname, "..", "..", "public");
    const logoCandidates = [
        "logo.png",
        "logo.jpg",
        "logo.jpeg",
        "logo_diaetgurken.png",
        "logo_diaetgurken.jpg",
        "logo_diaetgurken.jpeg",
    ];

    let logoSrc = "";
    let logoMimeType = "image/png";

    for (const candidate of logoCandidates) {
        const candidatePath = path.join(publicPath, candidate);
        if (fs.existsSync(candidatePath)) {
            const imageData = fs.readFileSync(candidatePath);
            logoMimeType = candidate.endsWith(".jpg") || candidate.endsWith(".jpeg") ? "image/jpeg" : "image/png";
            logoSrc = `data:${logoMimeType};base64,${imageData.toString("base64")}`;
            break;
        }
    }

    const html = await ejs.renderFile(templatePath, {
        ...data,
        logoSrc,
        colors: data.colors || pdfColors,
    });

    // Konvertierung von HTML zu DOCX
    const docxBuffer = await htmlToDocx(html, null, {
        table: { row: { cantSplit: true } },
        footer: true,
        pageNumber: true,
    });

    return docxBuffer;
}

module.exports = generatePdfFromTemplate;
module.exports.generatePdfFromTemplate = generatePdfFromTemplate;
module.exports.generateDocxFromTemplate = generateDocxFromTemplate;