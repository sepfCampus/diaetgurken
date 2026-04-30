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

        const akteResponse = await agent.post("/api/users/klientenakte").send({});
        expect(akteResponse.statusCode).toBe(201);

        const klientenAkteId = akteResponse.body.id;

        const updateResponse = await agent
            .put(`/api/users/klientenakten/${klientenAkteId}/klarname`)
            .send({ password: "123456", name: "Max Mustermann" });

        expect(updateResponse.statusCode).toBe(200);

        const getResponse = await agent
            .post(`/api/users/klientenakten/${klientenAkteId}/klarname`)
            .send({ password: "falsch123" });

        expect(getResponse.statusCode).toBe(401);
        expect(getResponse.body.error).toBe("Passwort ist nicht korrekt");
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

        const akteResponse = await agent.post("/api/users/klientenakte").send({});
        const klientenAkteId = akteResponse.body.id;

        await agent
            .put(`/api/users/klientenakten/${klientenAkteId}/klarname`)
            .send({ password: "123456", name: "Erika Mustermann" });

        const getResponse = await agent
            .post(`/api/users/klientenakten/${klientenAkteId}/klarname`)
            .send({ password: "123456" });

        expect(getResponse.statusCode).toBe(200);
        expect(getResponse.body.name).toBe("Erika Mustermann");
    });
});
