const router = require("express").Router();

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
router.use("/users", userRoutes);

// Nested routes under /users/klientenakten
// GET all: /users/klientenakten
router.use("/users/klientenakten", klientenAktenRoutes);
// POST create, DELETE remove: /users/klientenakte/:id
router.use("/users/klientenakte", klientenAktenRoutes);

// Nested routes under /users/klientenakten for Klarnamen
router.use("/users/klientenakten/:klientenAkteId/klarname", klarnamenRoutes);

// Nested routes under /users/klientenakten for Gespraeche
// GET all: /users/klientenakten/:klientenAkteId/gespraeche
router.use("/users/klientenakten/:klientenAkteId/gespraeche", gespraecheRoutes);
// POST create, PUT update, DELETE remove: /users/klientenakten/:klientenAkteId/gespraech/:id
router.use("/users/klientenakten/:klientenAkteId/gespraech", gespraecheRoutes);

// User Settings
router.use("/users/einstellung", einstellungenRoutes);

module.exports = router;