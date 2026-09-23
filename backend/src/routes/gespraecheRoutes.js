const router = require("express").Router({ mergeParams: true });
const gespraechController = require("../controllers/gespraechController");
const requireLogin = require("../middlewares/requireLogin");

/**
 * @swagger
 * /users/klientenakten/{klientenAkteId}/gespraeche:
 *   get:
 *     tags:
 *       - Benutzer - Klientenakten - Gespräche
 *     summary: Liefert alle Gespräche einer Klientenakte
 *     parameters:
 *       - in: path
 *         name: klientenAkteId
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Gespräche erfolgreich geladen
 *       401:
 *         description: Nicht eingeloggt
 *       403:
 *         description: Kein Zugriff auf diese Klientenakte
 *       404:
 *         description: Klientenakte nicht gefunden
 */
router.get("/", requireLogin, gespraechController.getAll);

/**
 * @swagger
 * /users/klientenakten/{klientenAkteId}/gespraech:
 *   post:
 *     tags:
 *       - Benutzer - Klientenakten - Gespräche
 *     summary: Erstellt ein neues Gespräch
 *     parameters:
 *       - in: path
 *         name: klientenAkteId
 *         required: true
 *         schema:
 *           type: integer
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - datum
 *             properties:
 *               datum:
 *                 type: string
 *                 format: date
 *                 example: 2026-04-04
 *               formMetaData:
 *                 type: object
 *                 example:
 *                  version: 1
 *                  fields:
 *                    - internalName: age
 *                      name: Alter
 *                      type: int
 *                      optional: false
 *               assessment:
 *                 type: object
 *                 example:
 *                   motivation: hoch
 *                   compliance: mittel
 *                   risikoFaktoren:
 *                     - rauchen
 *                     - stress
 *               diagnosen:
 *                 type: object
 *                 example:
 *                   - code: E66
 *                     description: Übergewicht
 *               ziele:
 *                 type: object
 *                 example:
 *                   - kurz: Gewichtsverlust von 5kg
 *                     lang: In den nächsten 3 Monaten 5kg abnehmen
 *                   - kurz: Bewegung erhöhen
 *                     lang: Mindestens 3x pro Woche sportliche Aktivität
 *               outcome:
 *                 type: object
 *                 example:
 *                   erfolg: ja
 *                   notizen: Gute Zusammenarbeit, Patient motiviert
 *               notizen:
 *                 type: string
 *                 example: Erstgespräch
 *               selectedFilters:
 *                 type: array
 *                 items:
 *                   type: string
 *                 example:
 *                   - filter1
 *                   - filter2
 *     responses:
 *       201:
 *         description: Gespräch erfolgreich erstellt
 *       400:
 *         description: Ungültige Eingabe
 *       401:
 *         description: Nicht eingeloggt
 *       403:
 *         description: Kein Zugriff auf diese Klientenakte
 *       404:
 *         description: Klientenakte nicht gefunden
 */
router.post("/", requireLogin, gespraechController.create);

/**
 * @swagger
 * /users/klientenakten/{klientenAkteId}/gespraech/{id}:
 *   put:
 *     tags:
 *       - Benutzer - Klientenakten - Gespräche
 *     summary: Aktualisiert ein Gespräch
 *     parameters:
 *       - in: path
 *         name: klientenAkteId
 *         required: true
 *         schema:
 *           type: integer
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - datum
 *             properties:
 *               datum:
 *                 type: string
 *                 format: date
 *                 example: 2026-04-05
 *               formMetaData:
 *                 type: object
 *                 example:
 *                   version: 1
 *                   fields:
 *                     - internalName: age
 *                       name: Alter
 *                       type: int
 *                       optional: false
 *               assessment:
 *                   type: object
 *                   example:
 *                     motivation: hoch
 *                     compliance: mittel
 *                     risikoFaktoren:
 *                       - rauchen
 *                       - stress  
 *               diagnosen:
 *                 type: object
 *                 example:
 *                   - code: E66
 *                     description: Übergewicht
 *               ziele:
 *                 type: object
 *                 example:
 *                   - kurz: Gewichtsverlust von 5kg
 *                     lang: In den nächsten 3 Monaten 5kg abnehmen
 *                   - kurz: Bewegung erhöhen
 *                     lang: Mindestens 3x pro Woche sportliche Aktivität
 *               outcome:
 *                 type: object
 *                 example:
 *                   erfolg: ja
 *                   notizen: Gute Zusammenarbeit, Patient motiviert
 *               notizen:
 *                 type: string
 *               selectedFilters:
 *                 type: array
 *                 items:
 *                   type: string
 *     responses:
 *       200:
 *         description: Gespräch erfolgreich aktualisiert
 *       400:
 *         description: Ungültige Eingabe
 *       401:
 *         description: Nicht eingeloggt
 *       403:
 *         description: Kein Zugriff auf diese Klientenakte
 *       404:
 *         description: Gespräch oder Klientenakte nicht gefunden
 */
router.put("/:id", requireLogin, gespraechController.update);

/**
 * @swagger
 * /users/klientenakten/{klientenAkteId}/gespraech/{id}:
 *   delete:
 *     tags:
 *       - Benutzer - Klientenakten - Gespräche
 *     summary: Löscht ein Gespräch
 *     parameters:
 *       - in: path
 *         name: klientenAkteId
 *         required: true
 *         schema:
 *           type: integer
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       204:
 *         description: Gespräch erfolgreich gelöscht
 *       401:
 *         description: Nicht eingeloggt
 *       403:
 *         description: Kein Zugriff auf dieses Gespräch
 *       404:
 *         description: Gespräch oder Klientenakte nicht gefunden
 */
router.delete("/:id", requireLogin, gespraechController.remove);

/**
 * @swagger
 * /users/klientenakten/{klientenAkteId}/gespraech/{gespraechId}/export/pdf:
 *   get:
 *     tags:
 *       - Benutzer - Klientenakten - Gespräche
 *     summary: Exportiert ein Gespräch als PDF
 *     parameters:
 *       - in: path
 *         name: klientenAkteId
 *         required: true
 *         schema:
 *           type: integer
 *       - in: path
 *         name: gespraechId
 *         required: true
 *         schema:
 *           type: integer
 *       - in: query
 *         name: schriftgroesse
 *         required: false
 *         schema:
 *           type: string
 *           enum: [standard, gross]
 *           example: gross
 *         description: Schriftgröße für den PDF-Export
 *       - in: query
 *         name: kontrast
 *         required: false
 *         schema:
 *           type: string
 *           enum: [standard, hoherKontrast]
 *           example: hoherKontrast
 *         description: Kontrastmodus im PDF-Export
 *     responses:
 *       200:
 *         description: PDF erfolgreich generiert
 *         content:
 *           application/pdf:
 *             schema:
 *               type: string
 *               format: binary
 *       401:
 *         description: Nicht eingeloggt
 *       403:
 *         description: Kein Zugriff auf dieses Gespräch
 *       404:
 *         description: Gespräch oder Klientenakte nicht gefunden
 */

/**
 * @swagger
 * /users/klientenakten/{klientenAkteId}/gespraech/{gespraechId}/export/docx:
 *   get:
 *     tags:
 *       - Benutzer - Klientenakten - Gespräche
 *     summary: Exportiert ein Gespräch als Word-Dokument
 *     parameters:
 *       - in: path
 *         name: klientenAkteId
 *         required: true
 *         schema:
 *           type: integer
 *       - in: path
 *         name: gespraechId
 *         required: true
 *         schema:
 *           type: integer
 *       - in: query
 *         name: schriftgroesse
 *         required: false
 *         schema:
 *           type: string
 *           enum: [standard, gross]
 *           example: gross
 *         description: Schriftgröße für den Word-Export
 *       - in: query
 *         name: kontrast
 *         required: false
 *         schema:
 *           type: string
 *           enum: [standard, hoherKontrast]
 *           example: hoherKontrast
 *         description: Kontrastmodus im Word-Export
 *     responses:
 *       200:
 *         description: Word-Dokument erfolgreich generiert
 *         content:
 *           application/vnd.openxmlformats-officedocument.wordprocessingml.document:
 *             schema:
 *               type: string
 *               format: binary
 *       401:
 *         description: Nicht eingeloggt
 *       403:
 *         description: Kein Zugriff auf dieses Gespräch
 *       404:
 *         description: Gespräch oder Klientenakte nicht gefunden
 */
const pdfExportController = require("../controllers/pdfExportController");
router.get("/:gespraechId/export/pdf", requireLogin, pdfExportController.exportGespräch);
router.get("/:gespraechId/export/docx", requireLogin, pdfExportController.exportGesprächDocx);

module.exports = router;
