const router = require("express").Router();
const requireLogin = require("../middlewares/requireLogin");

const healthRoutes = require("./healthRoutes");
const authRoutes = require("./authRoutes");
const userRoutes = require("./userRoutes");
const klientenAktenRoutes = require("./klientenAktenRoutes");
const einstellungenRoutes = require("./einstellungenRoutes");
const klarnamenRoutes = require("./klarnamenRoutes");
const gespraecheRoutes = require("./gespraecheRoutes");

// Health Check
router.use("/health", healthRoutes);

// Authentication
router.use("/auth", authRoutes);

// Users - hierarchically organized
router.use("/users", requireLogin, userRoutes);

// Nested routes under /users/klientenakten
router.use("/users/klientenakten", requireLogin, klientenAktenRoutes);
router.use("/users/klientenakte", requireLogin, klientenAktenRoutes);

// Nested routes under /users/klientenakten for Klarnamen
router.use("/users/klientenakten/:klientenAkteId/klarname", requireLogin, klarnamenRoutes);

// Nested routes under /users/klientenakten for Gespraeche
router.use("/users/klientenakten/:klientenAkteId/gespraeche", requireLogin, gespraecheRoutes);
router.use("/users/klientenakten/:klientenAkteId/gespraech", requireLogin, gespraecheRoutes);

// User Settings
router.use("/users/einstellung", requireLogin, einstellungenRoutes);

module.exports = router;