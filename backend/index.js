const app = require("./src/app");
const { startGrpcServer } = require("./src/grpc/server");
const { startGraphQL } = require("./src/graphql/server");
const notFoundHandler = require("./src/middlewares/notFoundHandler");
const errorHandler = require("./src/middlewares/errorHandler");

const PORT = process.env.PORT || 3000;

async function start() {
  await startGraphQL(app);

  app.use(notFoundHandler);
  app.use(errorHandler);

  app.listen(PORT, () => {
    console.log(`Backend läuft auf Port ${PORT}`);
  });

  startGrpcServer();
}

start().catch((err) => {
  console.error("Fehler beim Starten des Backends:", err);
});