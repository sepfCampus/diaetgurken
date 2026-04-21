const router = require("express").Router();
const userController = require("../controllers/userController");
const requireLogin = require("../middlewares/requireLogin");

/**
 * @swagger
 * /users:
 *   put:
 *     tags:
 *       - Benutzer
 *     summary: Aktualisiert den aktuell eingeloggten Benutzer
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - email
 *               - password
 *               - registerNr
 *             properties:
 *               email:
 *                 type: string
 *                 example: neu@test.at
 *               password:
 *                 type: string
 *                 example: neuespasswort123
 *               registerNr:
 *                 type: string
 *                 example: REG999
 *     responses:
 *       200:
 *         description: Benutzer erfolgreich aktualisiert
 *       400:
 *         description: Ungültige Eingabe
 *       401:
 *         description: Nicht eingeloggt
 *       404:
 *         description: Benutzer nicht gefunden
 *       409:
 *         description: E-Mail oder Registernummer bereits vergeben
 */
router.put("/", requireLogin, userController.updateUser);

/**
 * @swagger
 * /users:
 *   delete:
 *     tags:
 *       - Benutzer
 *     summary: Löscht den aktuell eingeloggten Benutzer
 *     responses:
 *       204:
 *         description: Benutzer erfolgreich gelöscht
 *       401:
 *         description: Nicht eingeloggt
 *       404:
 *         description: Benutzer nicht gefunden
 */
router.delete("/", requireLogin, userController.deleteUser);

module.exports = router;