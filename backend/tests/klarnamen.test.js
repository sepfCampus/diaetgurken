const request = require("supertest");
const app = require("../src/app");
const prisma = require("../src/db/prismaClient");

beforeEach(async () => {
    await prisma.user.deleteMany();
});

afterAll(async () => {
    await prisma.$disconnect();
});

describe("Klarnamen API", () => {
    test("GET Klarname mit falschem Passwort sollte 401 zurückgeben", async () => {
        const agent = request.agent(app);

        await agent.post("/api/auth/register").send({
            email: "klarname1@test.at",
            password: "123456",
            registerNr: "REG_KLAR_1",
        });

        await agent.post("/api/auth/login").send({
            email: "klarname1@test.at",
            password: "123456",
        });

        expect(loginResponse.statusCode).toBe(200);

        // 3. Klientenakte anlegen
        const akteResponse = await agent.post("/api/klientenAkten").send({});
        expect(akteResponse.statusCode).toBe(201);

        const klientenAkteId = akteResponse.body.id.toString();

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
    });

    test("GET Klarname mit richtigem Passwort sollte den Namen zurückgeben", async () => {
        const agent = request.agent(app);

        await agent.post("/api/auth/register").send({
            email: "klarname2@test.at",
            password: "123456",
            registerNr: "REG_KLAR_2",
        });

        await agent.post("/api/auth/login").send({
            email: "klarname2@test.at",
            password: "123456",
        });

        const akteResponse = await agent.post("/api/klientenAkten").send({});
        const klientenAkteId = akteResponse.body.id.toString();

        await agent.put("/api/klarnamen").send({
            klientenAkteId,
            password: "123456",
            name: "Erika Mustermann",
        });

        const getResponse = await agent.post("/api/klarnamen").send({
            klientenAkteId,
            password: "123456",
        });

        expect(getResponse.statusCode).toBe(200);
        expect(getResponse.body.name).toBe("Erika Mustermann");
    });
});
