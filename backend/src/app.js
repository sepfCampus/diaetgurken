const express = require("express");
const session = require("express-session");
const apiRoutes = require("./routes/api");
const swaggerUi = require("swagger-ui-express");
const swaggerSpec = require("./swagger");

const app = express();

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