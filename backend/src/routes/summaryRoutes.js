const router = require("express").Router({ mergeParams: true });
const requireLogin = require("../middlewares/requireLogin");
const summaryController = require("../controllers/summaryController");

/**
 * @swagger
 * /users/klientenakten/{klientenAkteId}/summary:
 *   post:
 *     tags:
 *       - Benutzer - Klientenakten - Zusammenfassung
 *     summary: Erzeugt eine überprüfbare Test-Zusammenfassung der Gespräche
 *     parameters:
 *       - in: path
 *         name: klientenAkteId
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Strukturierte, nicht gespeicherte Test-Zusammenfassung
 *       400:
 *         description: Ungültige KlientenAkteId
 *       401:
 *         description: Nicht eingeloggt
 *       403:
 *         description: Kein Zugriff auf diese Klientenakte
 *       404:
 *         description: Klientenakte nicht gefunden
 *       422:
 *         description: Keine Gespräche vorhanden
 *       502:
 *         description: Ungültige Provider-Antwort
 *       503:
 *         description: Zusammenfassungsdienst nicht verfügbar
 */
router.post("/", requireLogin, summaryController.create);

module.exports = router;
