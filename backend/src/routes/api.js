const router = require("express").Router();

const healthRoutes = require("./healthRoutes");
const authRoutes = require("./authRoutes");
const klientenAktenRoutes = require("./klientenAktenRoutes");
const klarnamenRoutes = require("./klarnamenRoutes");

router.use("/klientenAkten", klientenAktenRoutes);
router.use("/health", healthRoutes);
router.use("/auth", authRoutes);
router.use("/klarnamen", klarnamenRoutes);

module.exports = router;