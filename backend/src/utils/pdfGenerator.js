const fs = require("fs");
const path = require("path");
const ejs = require("ejs");
const puppeteer = require("puppeteer");
const htmlToDocx = require("html-to-docx");
const pdfColors = require("../config/pdfColors");

function formatScaledNumber(value) {
    const number = Number(value);

    if (!Number.isFinite(number)) {
        return "0";
    }

    if (Number.isInteger(number)) {
        return String(number);
    }

    return number.toFixed(2).replace(/\.0+$/, "").replace(/(\.\d*[1-9])0+$/, "$1");
}

function getSafeScale(fontScale) {
    const scale = Number(fontScale);

    if (!Number.isFinite(scale) || scale <= 1) {
        return 1;
    }

    return scale;
}

function getLogoScale(fontScale) {
    const scale = getSafeScale(fontScale);

    if (scale <= 1) {
        return 1;
    }

    return scale * 1.15;
}

function scaleDocxFontSizes(html, fontScale) {
    const scale = getSafeScale(fontScale);

    if (scale <= 1) {
        return html;
    }

    return html.replace(/font-size:\s*([0-9]+(?:\.[0-9]+)?)pt/gi, function (_match, size) {
        return "font-size: " + formatScaledNumber(Number(size) * scale) + "pt";
    });
}

function scaleDocxLogo(html, fontScale) {
    const logoScale = getLogoScale(fontScale);

    if (logoScale <= 1) {
        return html;
    }

    return html.replace(/<img\b[^>]*>/gi, function (imgTag) {
        if (!/alt=(["'])Logo\1/i.test(imgTag)) {
            return imgTag;
        }

        let scaledImgTag = imgTag;

        scaledImgTag = scaledImgTag.replace(/\bwidth=(["'])([0-9]+(?:\.[0-9]+)?)\1/i, function (_match, quote, width) {
            return "width=" + quote + formatScaledNumber(Number(width) * logoScale) + quote;
        });

        scaledImgTag = scaledImgTag.replace(/width:\s*([0-9]+(?:\.[0-9]+)?)px/gi, function (_match, width) {
            return "width: " + formatScaledNumber(Number(width) * logoScale) + "px";
        });

        return scaledImgTag;
    });
}

function applyDocxFontScale(html, fontScale) {
    let scaledHtml = html;

    scaledHtml = scaleDocxFontSizes(scaledHtml, fontScale);
    scaledHtml = scaleDocxLogo(scaledHtml, fontScale);

    return scaledHtml;
}

function getLogoSrc() {
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

    return logoSrc;
}

async function generatePdfFromTemplate(templateName, data) {
    const templatePath = path.join(__dirname, "..", "templates", templateName);
    const logoSrc = getLogoSrc();

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
    const logoSrc = getLogoSrc();

    const html = await ejs.renderFile(templatePath, {
        ...data,
        logoSrc,
        colors: data.colors || pdfColors,
    });

    const docxHtml = applyDocxFontScale(html, data.fontScale);

    const docxBuffer = await htmlToDocx(docxHtml, null, {
        table: { row: { cantSplit: true } },
        footer: true,
        pageNumber: true,
    });

    return docxBuffer;
}

module.exports = generatePdfFromTemplate;
module.exports.generatePdfFromTemplate = generatePdfFromTemplate;
module.exports.generateDocxFromTemplate = generateDocxFromTemplate;