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

function normalizeHex(value) {
    if (!value || typeof value !== "string") {
        return "";
    }

    return value.trim().toLowerCase();
}

function isHighContrastColors(colors) {
    return normalizeHex(colors?.PRIMARY) === "#4d1e22";
}

function replaceHexColor(html, fromHex, toHex) {
    if (!fromHex || !toHex) {
        return html;
    }

    const escapedHex = fromHex.replace("#", "\\#");
    const regex = new RegExp(escapedHex, "gi");

    return html.replace(regex, toHex);
}

function setStyleProperty(attributes, propertyName, propertyValue) {
    const styleRegex = /\sstyle=(['"])(.*?)\1/i;

    if (!styleRegex.test(attributes)) {
        return attributes + " style=\"" + propertyName + ": " + propertyValue + ";\"";
    }

    return attributes.replace(styleRegex, function (_match, quote, styleValue) {
        const propertyRegex = new RegExp(propertyName + "\\s*:\\s*[^;]+;?", "i");
        let nextStyleValue = styleValue;

        if (propertyRegex.test(nextStyleValue)) {
            nextStyleValue = nextStyleValue.replace(propertyRegex, propertyName + ": " + propertyValue + ";");
        } else {
            nextStyleValue = nextStyleValue.trim();

            if (nextStyleValue && !nextStyleValue.endsWith(";")) {
                nextStyleValue += ";";
            }

            nextStyleValue += " " + propertyName + ": " + propertyValue + ";";
        }

        return " style=" + quote + nextStyleValue + quote;
    });
}

function applyStyleToOpeningTagByRole(html, role, propertyName, propertyValue) {
    const roleRegex = new RegExp("<p\\b([^>]*data-docx-role=(['\"])" + role + "\\2[^>]*)>", "gi");

    return html.replace(roleRegex, function (_match, attributes) {
        const nextAttributes = setStyleProperty(attributes, propertyName, propertyValue);

        return "<p" + nextAttributes + ">";
    });
}

function applyDocxHighContrastRoleColors(html, colors) {
    if (!isHighContrastColors(colors)) {
        return html;
    }

    let nextHtml = html;

    nextHtml = applyStyleToOpeningTagByRole(nextHtml, "document-title", "color", colors.PRIMARY || "#4d1e22");
    nextHtml = applyStyleToOpeningTagByRole(nextHtml, "goal-subtitle", "color", colors.SECONDARY || "#968daf");

    return nextHtml;
}

function applyDocxHighContrastColors(html, colors) {
    if (!isHighContrastColors(colors)) {
        return html;
    }

    let contrastHtml = html;

    const highContrastColors = {
        primary: colors.PRIMARY || "#4d1e22",
        secondary: colors.SECONDARY || "#968daf",
        tertiary: colors.TERTIARY || "#6b4c2f",
        quaternary: colors.QUATERNARY || "#0F4A74",
        pageBackground: colors.PAGE_BACKGROUND || "#FFFFFF",
        cardBackground: colors.CARD_BACKGROUND || "#FFFFFF",
        text: colors.TEXT || "#000000",
        mutedText: colors.MUTED_TEXT || "#222222",
        border: colors.BORDER || "#000000",
    };

    contrastHtml = replaceHexColor(contrastHtml, "#F8FBF8", highContrastColors.pageBackground);
    contrastHtml = replaceHexColor(contrastHtml, "#245B2B", highContrastColors.primary);
    contrastHtml = replaceHexColor(contrastHtml, "#EDF6EF", highContrastColors.cardBackground);
    contrastHtml = replaceHexColor(contrastHtml, "#D8E4D8", highContrastColors.border);
    contrastHtml = replaceHexColor(contrastHtml, "#222222", highContrastColors.text);
    contrastHtml = replaceHexColor(contrastHtml, "#44505A", highContrastColors.mutedText);
    contrastHtml = replaceHexColor(contrastHtml, "#6B7280", highContrastColors.mutedText);
    contrastHtml = replaceHexColor(contrastHtml, "#1D768F", highContrastColors.quaternary);
    contrastHtml = replaceHexColor(contrastHtml, "#A7C0A5", highContrastColors.secondary);
    contrastHtml = replaceHexColor(contrastHtml, "#FFFBE6", highContrastColors.cardBackground);
    contrastHtml = replaceHexColor(contrastHtml, "#FBC02D", highContrastColors.tertiary);

    contrastHtml = applyDocxHighContrastRoleColors(contrastHtml, colors);

    return contrastHtml;
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

function removeDocxHelperAttributes(html) {
    return html.replace(/\sdata-docx-role=(["']).*?\1/gi, "");
}

function applyDocxTransformations(html, data) {
    let transformedHtml = html;

    transformedHtml = applyDocxHighContrastColors(transformedHtml, data.colors);
    transformedHtml = scaleDocxFontSizes(transformedHtml, data.fontScale);
    transformedHtml = scaleDocxLogo(transformedHtml, data.fontScale);
    transformedHtml = removeDocxHelperAttributes(transformedHtml);

    return transformedHtml;
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

    const docxHtml = applyDocxTransformations(html, {
        ...data,
        colors: data.colors || pdfColors,
    });

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