const router = require("express").Router();
const gespraechController = require("../controllers/gespraechController");
const requireLogin = require("../middlewares/requireLogin");

/**
 * @swagger
 * /gespraeche/{klientenAkteId}:
 *   get:
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
router.get("/:klientenAkteId", requireLogin, gespraechController.getAll);

/**
 * @swagger
 * /gespraeche:
 *   post:
 *     summary: Erstellt ein neues Gespräch
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - klientenAkteId
 *               - datum
 *             properties:
 *               klientenAkteId:
 *                 type: integer
 *                 example: 1
 *               datum:
 *                 type: string
 *                 example: 2026-04-04
 *               formMetaData:
 *                 type: object
 *               assessment:
 *                 type: object
 *               diagnosen:
 *                 type: object
 *               ziele:
 *                 type: object
 *               outcome:
 *                 type: object
 *               notizen:
 *                 type: string
 *                 example: Erstgespräch
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
 * /gespraeche:
 *   put:
 *     summary: Aktualisiert ein Gespräch
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - id
 *               - klientenAkteId
 *               - datum
 *             properties:
 *               id:
 *                 type: integer
 *                 example: 1
 *               klientenAkteId:
 *                 type: integer
 *                 example: 1
 *               datum:
 *                 type: string
 *                 example: 2026-04-05
 *               formMetaData:
 *                 type: object
 *               assessment:
 *                 type: object
 *               diagnosen:
 *                 type: object
 *               ziele:
 *                 type: object
 *               outcome:
 *                 type: object
 *               notizen:
 *                 type: string
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
router.put("/", requireLogin, gespraechController.update);

/**
 * @swagger
 * /gespraeche/{id}:
 *   delete:
 *     summary: Löscht ein Gespräch
 *     parameters:
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

module.exports = router;