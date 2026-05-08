const path = require("path");
const ejs = require("ejs");
const puppeteer = require("puppeteer");

async function generatePdfFromTemplate(templateName, data) {
    const templatePath = path.join(__dirname, "..", "templates", templateName);
    const html = await ejs.renderFile(templatePath, data);

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

module.exports = generatePdfFromTemplate;
module.exports.generatePdfFromTemplate = generatePdfFromTemplate;