const app = require("./src/app");
const { startGrpcServer } = require("./src/grpc/server");

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(`Backend läuft auf Port ${PORT}`);
});

startGrpcServer();