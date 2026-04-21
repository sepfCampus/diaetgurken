const express = require("express");
const session = require("express-session");
const apiRoutes = require("./routes/api");
const swaggerUi = require("swagger-ui-express");
const swaggerSpec = require("./swagger");
const cors = require('cors');

const app = express();

app.use(cors({ origin: 'http://localhost:5173', credentials: true }));

app.use(express.json());
app.use("/api-docs", swaggerUi.serve, swaggerUi.setup(swaggerSpec));

app.use(
    session({
        secret: "dev-secret-change-later",
        resave: false,
        saveUninitialized: false,
        cookie: {
            httpOnly: true,
        },
    })
);

app.use("/api", apiRoutes);

module.exports = app;