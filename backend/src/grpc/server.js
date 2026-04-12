const path = require("path");
const grpc = require("@grpc/grpc-js");
const protoLoader = require("@grpc/proto-loader");
const gespraechHandler = require("./handlers/gespraechGrpcHandler");

const PROTO_PATH = path.join(__dirname, "protos", "gespraech.proto");

const packageDefinition = protoLoader.loadSync(PROTO_PATH, {
    keepCase: true,
    longs: String,
    enums: String,
    defaults: true,
    oneofs: true,
});

const proto = grpc.loadPackageDefinition(packageDefinition);

function startGrpcServer() {
    const server = new grpc.Server();

    server.addService(proto.gespraech.GespraechService.service, gespraechHandler);

    const address = "0.0.0.0:50051";

    server.bindAsync(address, grpc.ServerCredentials.createInsecure(), (err, port) => {
        if (err) {
            console.error("gRPC Server konnte nicht gestartet werden:", err);
            return;
        }

        console.log(`gRPC Server läuft auf Port ${port}`);
    });
}

module.exports = { startGrpcServer };