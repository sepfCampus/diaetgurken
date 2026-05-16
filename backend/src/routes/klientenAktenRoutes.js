const router = require("express").Router();
const klientenAkteController = require("../controllers/klientenAkteController");
const requireLogin = require("../middlewares/requireLogin");

/**
 * @swagger
 * /users/klientenakten:
 *   get:
 *     tags:
 *       - Benutzer - Klientenakten
 *     summary: Liefert alle Klientenakten des eingeloggten Benutzers
 *     responses:
 *       200:
 *         description: Liste der Klientenakten
 *       401:
 *         description: Nicht eingeloggt
 */
router.get("/", requireLogin, klientenAkteController.getAll);

/**
 * @swagger
 * /users/klientenakte:
 *   post:
 *     tags:
 *       - Benutzer - Klientenakten
 *     summary: Legt eine neue Klientenakte für den eingeloggten Benutzer an
 *     requestBody:
 *       required: false
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               name:
 *                 type: string
 *                 description: Klarname zur neuen Klientenakte
 *                 example: "Max Mustermann"
 *     responses:
 *       201:
 *         description: Klientenakte erfolgreich angelegt
 *       401:
 *         description: Nicht eingeloggt
 */
router.post("/", requireLogin, klientenAkteController.create);

/**
 * @swagger
 * /users/klientenakte/{id}:
 *   delete:
 *     tags:
 *       - Benutzer - Klientenakten
 *     summary: Löscht eine Klientenakte des eingeloggten Benutzers
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       204:
 *         description: Erfolgreich gelöscht
 *       401:
 *         description: Nicht eingeloggt
 *       403:
 *         description: Kein Zugriff auf diese Klientenakte
 *       404:
 *         description: Klientenakte nicht gefunden
 */
router.delete("/:id", requireLogin, klientenAkteController.remove);



module.exports = router;