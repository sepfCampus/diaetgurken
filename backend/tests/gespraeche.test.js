const request = require("supertest");
const app = require("../src/app");
const prisma = require("../src/db/prismaClient");

beforeEach(async () => {
    await prisma.user.deleteMany();
});

afterAll(async () => {
    await prisma.$disconnect();
});

describe("Gespraeche API", () => {
    test("GET Gespraeche ohne Login sollte 401 zurückgeben", async () => {
        const response = await request(app).get("/api/users/klientenakten/1/gespraeche");

        expect(response.statusCode).toBe(401);
        expect(response.body.error).toBe("Nicht eingeloggt");
    });

    test("POST und GET Gespraeche sollten für eigene KlientenAkte funktionieren", async () => {
        const agent = request.agent(app);

        await agent.post("/api/auth/register").send({
            email: "gespraech1@test.at",
            password: "123456",
            registerNr: "REG_GESP_1",
        });
        await agent.post("/api/auth/login").send({
            email: "gespraech1@test.at",
            password: "123456",
        });

        const akteResponse = await agent.post("/api/users/klientenakte").send({});
        expect(akteResponse.statusCode).toBe(201);

        const klientenAkteId = akteResponse.body.id;
        expect(klientenAkteId).toBeDefined();

        const createRes = await agent
            .post(`/api/users/klientenakten/${klientenAkteId}/gespraech`)
            .send({
                datum: "2026-04-04",
                formMetaData: { version: 1 },
                assessment: { gewicht: 85 },
                diagnosen: { hauptdiagnose: "Adipositas" },
                ziele: { ziel1: "Gewichtsreduktion" },
                outcome: { status: "offen" },
                notizen: "Erstgespräch",
            });

        expect(createRes.statusCode).toBe(201);

        const getRes = await agent.get(`/api/users/klientenakten/${klientenAkteId}/gespraeche`);

        expect(getRes.statusCode).toBe(200);
        expect(getRes.body.length).toBe(1);
        expect(getRes.body[0].assessment.gewicht).toBe(85);
        expect(getRes.body[0].diagnosen.hauptdiagnose).toBe("Adipositas");
    });

    test("DELETE Gespraech sollte eigenes Gespräch löschen", async () => {
        const agent = request.agent(app);

        await agent.post("/api/auth/register").send({
            email: "gespraech2@test.at",
            password: "123456",
            registerNr: "REG_GESP_2",
        });
        await agent.post("/api/auth/login").send({
            email: "gespraech2@test.at",
            password: "123456",
        });

        const akteRes = await agent.post("/api/users/klientenakte").send({});
        const klientenAkteId = akteRes.body.id;

        const createRes = await agent
            .post(`/api/users/klientenakten/${klientenAkteId}/gespraech`)
            .send({ datum: "2026-04-05", notizen: "Zu löschen" });

        const gespraechId = createRes.body.id;

        const deleteRes = await agent.delete(
            `/api/users/klientenakten/${klientenAkteId}/gespraech/${gespraechId}`
        );
        expect(deleteRes.statusCode).toBe(204);

        const getRes = await agent.get(`/api/users/klientenakten/${klientenAkteId}/gespraeche`);
        expect(getRes.body.length).toBe(0);
    });

    test("GET auf fremde KlientenAkte sollte 403 zurückgeben", async () => {
        const agentA = request.agent(app);
        const agentB = request.agent(app);

        await agentA.post("/api/auth/register").send({
            email: "owner@test.at",
            password: "123456",
            registerNr: "REG_OWNER",
        });
        await agentA.post("/api/auth/login").send({
            email: "owner@test.at",
            password: "123456",
        });

        const akteRes = await agentA.post("/api/users/klientenakte").send({});
        const klientenAkteId = akteRes.body.id;

        await agentB.post("/api/auth/register").send({
            email: "intruder@test.at",
            password: "123456",
            registerNr: "REG_INTRUDER",
        });
        await agentB.post("/api/auth/login").send({
            email: "intruder@test.at",
            password: "123456",
        });

        const res = await agentB.get(`/api/users/klientenakten/${klientenAkteId}/gespraeche`);
        expect(res.statusCode).toBe(403);
    });

    test("PUT sollte JSON-Felder aktualisieren", async () => {
        const agent = request.agent(app);

        await agent.post("/api/auth/register").send({
            email: "update@test.at",
            password: "123456",
            registerNr: "REG_UPDATE",
        });
        await agent.post("/api/auth/login").send({
            email: "update@test.at",
            password: "123456",
        });

        const akteRes = await agent.post("/api/users/klientenakte").send({});
        const klientenAkteId = akteRes.body.id;

        const createRes = await agent
            .post(`/api/users/klientenakten/${klientenAkteId}/gespraech`)
            .send({ datum: "2026-04-04", assessment: { motivation: "hoch" } });

        const gespraechId = createRes.body.id;

        await agent
            .put(`/api/users/klientenakten/${klientenAkteId}/gespraech/${gespraechId}`)
            .send({ datum: "2026-04-05", assessment: { motivation: "niedrig" } });

        const getRes = await agent.get(`/api/users/klientenakten/${klientenAkteId}/gespraeche`);
        expect(getRes.body[0].assessment.motivation).toBe("niedrig");
    });

    test("POST Gespraech sollte null-JSON-Felder erlauben", async () => {
        const agent = request.agent(app);

        await agent.post("/api/auth/register").send({
            email: "null@test.at",
            password: "123456",
            registerNr: "REG_NULL",
        });
        await agent.post("/api/auth/login").send({
            email: "null@test.at",
            password: "123456",
        });

        const akteRes = await agent.post("/api/users/klientenakte").send({});
        const klientenAkteId = akteRes.body.id;

        const res = await agent
            .post(`/api/users/klientenakten/${klientenAkteId}/gespraech`)
            .send({ datum: "2026-04-04", assessment: null });

        expect(res.statusCode).toBe(201);
        expect(res.body.assessment).toBeNull();
    });
});
