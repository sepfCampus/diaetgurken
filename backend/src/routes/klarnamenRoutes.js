const router = require("express").Router({ mergeParams: true });
const klarnameController = require("../controllers/klarnameController");
const requireLogin = require("../middlewares/requireLogin");

/**
 * @swagger
 * /users/klientenakten/{klientenAkteId}/klarname:
 *   post:
 *     tags:
 *       - Benutzer - Klientenakten - Klarname
 *     summary: Liefert den Klarname zu einer Klientenakte
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
 *               - password
 *             properties:
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
 * /users/klientenakten/{klientenAkteId}/klarname:
 *   put:
 *     tags:
 *       - Benutzer - Klientenakten - Klarname
 *     summary: Ändert den Klarname zu einer Klientenakte
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
 *               - password
 *               - name
 *             properties:
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