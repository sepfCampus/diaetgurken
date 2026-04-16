const app = require("./src/app");
const notFoundHandler = require("./src/middlewares/notFoundHandler");
const errorHandler = require("./src/middlewares/errorHandler");

const PORT = process.env.PORT || 3000;

async function start() {
  app.use(notFoundHandler);
  app.use(errorHandler);

  app.listen(PORT, () => {
    console.log(`Backend läuft auf Port ${PORT}`);
  });
}

start().catch((err) => {
  console.error("Fehler beim Starten des Backends:", err);
});