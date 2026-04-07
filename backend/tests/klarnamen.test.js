const request = require("supertest");
const app = require("../src/app");
const prisma = require("../src/db/prismaClient");

beforeEach(async () => {
    await prisma.klarname.deleteMany();
    await prisma.gespraech.deleteMany();
    await prisma.einstellungen.deleteMany();
    await prisma.klientenAkte.deleteMany();
    await prisma.user.deleteMany();
});

afterAll(async () => {
    await prisma.$disconnect();
});

describe("Klarnamen API", () => {
    test("POST /api/klarnamen should return 401 for wrong password", async () => {
        const agent = request.agent(app);

        // 1. User registrieren
        const registerResponse = await agent
            .post("/api/auth/register")
            .send({
                email: "klarname1@test.at",
                password: "123456",
                registerNr: "REG_KLAR_1",
            });

        expect(registerResponse.statusCode).toBe(201);

        // 2. Login
        const loginResponse = await agent
            .post("/api/auth/login")
            .send({
                email: "klarname1@test.at",
                password: "123456",
            });

        expect(loginResponse.statusCode).toBe(200);

        // 3. Klientenakte anlegen
        const akteResponse = await agent.post("/api/klientenAkten").send({});
        expect(akteResponse.statusCode).toBe(201);

        const klientenAkteId = akteResponse.body.id;

        // 4. Klarname setzen
        const updateResponse = await agent
            .put("/api/klarnamen")
            .send({
                klientenAkteId,
                password: "123456",
                name: "Max Mustermann",
            });

        expect(updateResponse.statusCode).toBe(200);

        // 5. Klarname mit falschem Passwort abrufen
        const getResponse = await agent
            .post("/api/klarnamen")
            .send({
                klientenAkteId,
                password: "falsch123",
            });

        expect(getResponse.statusCode).toBe(401);
        expect(getResponse.body.error).toBe("Passwort ist nicht korrekt");
    });
});