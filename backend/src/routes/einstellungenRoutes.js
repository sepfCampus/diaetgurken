const router = require('express').Router();
const einstellungenController = require('../controllers/einstellungenController');
const requireLogin = require('../middlewares/requireLogin');

/**
 * @swagger
 * /users/einstellung:
 *   get:
 *     tags:
 *       - Benutzer - Einstellung
 *     summary: Liefert die Einstellungen des aktuell eingeloggten Benutzers
 *     responses:
 *       200:
 *         description: Einstellungen erfolgreich geladen
 *       401:
 *         description: Nicht eingeloggt
 */
router.get('/', requireLogin, einstellungenController.getEinstellungen);

/**
 * @swagger
 * /users/einstellung:
 *   put:
 *     tags:
 *       - Benutzer - Einstellung
 *     summary: Ändert die Einstellungen des aktuell eingeloggten Benutzers
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - farbdarstellung
 *               - schriftgroesse
 *             properties:
 *               farbdarstellung:
 *                 type: string
 *                 example: hoherKontrast
 *               schriftgroesse:
 *                 type: string
 *                 example: gross
 *     responses:
 *       200:
 *         description: Einstellungen erfolgreich geändert
 *       400:
 *         description: Ungültige Eingabe
 *       401:
 *         description: Nicht eingeloggt
 */
router.put('/', requireLogin, einstellungenController.updateEinstellungen);

module.exports = router;