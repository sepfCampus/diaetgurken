const router = require("express").Router();
const healthController = require("../controllers/healthController");

/**
 * @swagger
 * /health:
 *   get:
 *     tags:
 *       - Systemstatus
 *     summary: Prüft, ob das Backend läuft
 *     responses:
 *       200:
 *         description: Backend ist erreichbar
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 status:
 *                   type: string
 *                   example: ok
 */
router.get("/", healthController.getHealth);

module.exports = router;