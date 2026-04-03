const router = require("express").Router();
const klarnameController = require("../controllers/klarnameController");
const requireLogin = require("../middlewares/requireLogin");

/**
 * @swagger
 * /klarnamen:
 *   post:
 *     summary: Liefert den Klarname zu einer Klientenakte
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - klientenAkteId
 *               - password
 *             properties:
 *               klientenAkteId:
 *                 type: integer
 *                 example: 1
 *               password:
 *                 type: string
 *                 example: 123456
 *     responses:
 *       200:
 *         description: Klarname erfolgreich geladen
 *       400:
 *         description: Ungültige Eingabe
 *       401:
 *         description: Nicht eingeloggt oder Passwort falsch
 *       403:
 *         description: Kein Zugriff auf diese Klientenakte
 *       404:
 *         description: Klientenakte oder Klarname nicht gefunden
 */
router.post("/", requireLogin, klarnameController.getKlarname);

/**
 * @swagger
 * /klarnamen:
 *   put:
 *     summary: Ändert den Klarname zu einer Klientenakte
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - klientenAkteId
 *               - password
 *               - name
 *             properties:
 *               klientenAkteId:
 *                 type: integer
 *                 example: 1
 *               password:
 *                 type: string
 *                 example: 123456
 *               name:
 *                 type: string
 *                 example: Max Mustermann
 *     responses:
 *       200:
 *         description: Klarname erfolgreich geändert
 *       400:
 *         description: Ungültige Eingabe
 *       401:
 *         description: Nicht eingeloggt oder Passwort falsch
 *       403:
 *         description: Kein Zugriff auf diese Klientenakte
 *       404:
 *         description: Klientenakte nicht gefunden
 */
router.put("/", requireLogin, klarnameController.updateKlarname);

module.exports = router;