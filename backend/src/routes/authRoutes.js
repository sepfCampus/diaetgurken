const router = require("express").Router();
const authController = require("../controllers/authController");
const requireLogin = require("../middlewares/requireLogin");

/**
 * @swagger
 * /auth/register:
 *   post:
 *     summary: Registriert einen neuen Benutzer
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
 *                 example: test@test.at
 *               password:
 *                 type: string
 *                 example: 123456
 *               registerNr:
 *                 type: string
 *                 example: REG001
 *     responses:
 *       201:
 *         description: Benutzer erfolgreich registriert
 *       400:
 *         description: Ungültige Eingabe
 *       409:
 *         description: E-Mail oder Registernummer bereits vorhanden
 */
router.post("/register", authController.register);

/**
 * @swagger
 * /auth/login:
 *   post:
 *     summary: Meldet einen Benutzer an
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - email
 *               - password
 *             properties:
 *               email:
 *                 type: string
 *                 example: test@test.at
 *               password:
 *                 type: string
 *                 example: 123456
 *     responses:
 *       200:
 *         description: Login erfolgreich
 *       400:
 *         description: Ungültige Eingabe
 *       401:
 *         description: Ungültige Anmeldedaten
 */
router.post("/login", authController.login);

/**
 * @swagger
 * /auth/logout:
 *   post:
 *     summary: Meldet den aktuell eingeloggten Benutzer ab
 *     responses:
 *       200:
 *         description: Logout erfolgreich
 */
router.post("/logout", authController.logout);

/**
 * @swagger
 * /auth/whoami:
 *   get:
 *     summary: Liefert den aktuell eingeloggten Benutzer
 *     responses:
 *       200:
 *         description: Aktueller Benutzer
 *       401:
 *         description: Nicht eingeloggt
 */
router.get("/whoami", requireLogin, authController.whoami);

module.exports = router;