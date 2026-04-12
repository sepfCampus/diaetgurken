const path = require("path");
const grpc = require("@grpc/grpc-js");
const protoLoader = require("@grpc/proto-loader");

const PROTO_PATH = path.join(__dirname, "protos", "gespraech.proto");

const packageDefinition = protoLoader.loadSync(PROTO_PATH, {
    keepCase: true,
    longs: String,
    enums: String,
    defaults: true,
    oneofs: true,
});

const proto = grpc.loadPackageDefinition(packageDefinition);

const client = new proto.gespraech.GespraechService(
    "localhost:50051",
    grpc.credentials.createInsecure()
);

const userId = 1;
const klientenAkteId = 1;

client.CreateGespraech(
    {
        userId,
        klientenAkteId,
        datum: "2026-04-11",
        formMetaData: JSON.stringify({ version: 1 }),
        assessment: JSON.stringify({ gewicht: 85 }),
        diagnosen: JSON.stringify({ hauptdiagnose: "Adipositas" }),
        ziele: JSON.stringify({ ziel1: "Gewichtsreduktion" }),
        outcome: JSON.stringify({ status: "offen" }),
        notizen: "gRPC Test",
    },
    (err, response) => {
        if (err) {
            console.error("Fehler bei CreateGespraech:", err);
            return;
        }

        console.log("Create Response:", response);

        client.GetGespraeche(
            {
                userId,
                klientenAkteId,
            },
            (err, response) => {
                if (err) {
                    console.error("Fehler bei GetGespraeche:", err);
                    return;
                }

                console.log("GetGespraeche Response:", response);
            }
        );
    }
);