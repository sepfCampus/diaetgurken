const fs = require("fs");
const path = require("path");
const ejs = require("ejs");
const puppeteer = require("puppeteer");
const htmlToDocx = require("html-to-docx");
const pdfColors = require("../config/pdfColors");

function escapeXml(value) {
    return String(value)
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&apos;");
}

function createPdfUaXmp(title) {
    const escapedTitle = escapeXml(title);

    return `<?xpacket begin="\uFEFF" id="W5M0MpCehiHzreSzNTczkc9d"?>
<x:xmpmeta xmlns:x="adobe:ns:meta/">
  <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
    <rdf:Description rdf:about=""
      xmlns:dc="http://purl.org/dc/elements/1.1/"
      xmlns:pdf="http://ns.adobe.com/pdf/1.3/"
      xmlns:pdfuaid="http://www.aiim.org/pdfua/ns/id/"
      xmlns:xmp="http://ns.adobe.com/xap/1.0/">
      <dc:title>
        <rdf:Alt>
          <rdf:li xml:lang="de-DE">${escapedTitle}</rdf:li>
        </rdf:Alt>
      </dc:title>
      <dc:creator>
        <rdf:Seq>
          <rdf:li>Diaetgurken</rdf:li>
        </rdf:Seq>
      </dc:creator>
      <pdf:Producer>Diaetgurken PDF Export</pdf:Producer>
      <xmp:CreatorTool>Diaetgurken PDF Export</xmp:CreatorTool>
      <pdfuaid:part>1</pdfuaid:part>
    </rdf:Description>
  </rdf:RDF>
</x:xmpmeta>
<?xpacket end="w"?>`;
}

function appendPdfUaMetadata(pdfData, title) {
    const original = Buffer.from(pdfData);
    const pdf = original.toString("latin1");
    const trailerMatch = pdf.match(/trailer\s*<<([\s\S]*?)>>\s*startxref\s*(\d+)\s*%%EOF\s*$/);

    if (!trailerMatch) {
        return original;
    }

    const trailer = trailerMatch[1];
    const previousXrefOffset = Number(trailerMatch[2]);
    const sizeMatch = trailer.match(/\/Size\s+(\d+)/);
    const rootMatch = trailer.match(/\/Root\s+(\d+)\s+(\d+)\s+R/);
    const infoMatch = trailer.match(/\/Info\s+(\d+)\s+(\d+)\s+R/);

    if (!sizeMatch || !rootMatch || !Number.isFinite(previousXrefOffset)) {
        return original;
    }

    const size = Number(sizeMatch[1]);
    const rootObjectNumber = Number(rootMatch[1]);
    const rootGeneration = Number(rootMatch[2]);
    const metadataObjectNumber = size;
    const newSize = metadataObjectNumber + 1;
    const rootPattern = new RegExp(`${rootObjectNumber}\\s+${rootGeneration}\\s+obj\\s*([\\s\\S]*?)\\s*endobj`);
    const rootObjectMatch = pdf.match(rootPattern);

    if (!rootObjectMatch) {
        return original;
    }

    const rootDictionary = rootObjectMatch[1].replace(/\/Metadata\s+\d+\s+\d+\s+R\s*/g, "");
    const updatedRootDictionary = rootDictionary.replace(/>>\s*$/, `/Metadata ${metadataObjectNumber} 0 R>>`);
    const xmp = Buffer.from(createPdfUaXmp(title), "utf8");
    const metadataHeader = Buffer.from(
        `${metadataObjectNumber} 0 obj\n<</Type /Metadata\n/Subtype /XML\n/Length ${xmp.length}>>\nstream\n`,
        "latin1"
    );
    const metadataFooter = Buffer.from("\nendstream\nendobj\n", "latin1");
    const updatedRoot = Buffer.from(
        `${rootObjectNumber} ${rootGeneration} obj\n${updatedRootDictionary}\nendobj\n`,
        "latin1"
    );
    const rootOffset = original.length + metadataHeader.length + xmp.length + metadataFooter.length;
    const metadataOffset = original.length;
    const xrefOffset = rootOffset + updatedRoot.length;
    const infoTrailerEntry = infoMatch ? `\n/Info ${infoMatch[1]} ${infoMatch[2]} R` : "";
    const incrementalXref = Buffer.from(
        `xref\n${rootObjectNumber} 1\n${String(rootOffset).padStart(10, "0")} ${String(rootGeneration).padStart(5, "0")} n \n${metadataObjectNumber} 1\n${String(metadataOffset).padStart(10, "0")} 00000 n \ntrailer\n<</Size ${newSize}\n/Root ${rootObjectNumber} ${rootGeneration} R${infoTrailerEntry}\n/Prev ${previousXrefOffset}>>\nstartxref\n${xrefOffset}\n%%EOF\n`,
        "latin1"
    );

    return Buffer.concat([original, metadataHeader, xmp, metadataFooter, updatedRoot, incrementalXref]);
}

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

        const pdfBuffer = await page.pdf({
            format: "A4",
            printBackground: true,
            tagged: true,
            outline: true,
            margin: {
                top: "20mm",
                right: "15mm",
                bottom: "20mm",
                left: "15mm",
            },
        });

        return appendPdfUaMetadata(pdfBuffer, data.pdfTitle || "Diätologisches Assessmentblatt");
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
