const router = require("express").Router();

const healthRoutes = require("./healthRoutes");
const authRoutes = require("./authRoutes");
const klientenAktenRoutes = require("./klientenAktenRoutes");
const klarnamenRoutes = require("./klarnamenRoutes");
const einstellungenRoutes = require("./einstellungenRoutes");
const userRoutes = require("./userRoutes");
const gespraecheRoutes = require("./gespraecheRoutes");

router.use("/klientenAkten", klientenAktenRoutes);
router.use("/health", healthRoutes);
router.use("/auth", authRoutes);
router.use("/klarnamen", klarnamenRoutes);
router.use("/einstellungen", einstellungenRoutes);
router.use("/users", userRoutes);
router.use("/gespraeche", gespraecheRoutes);

module.exports = router;