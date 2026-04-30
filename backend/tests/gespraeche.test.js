const request = require("supertest");
const app = require("../src/app");
const mongoose = require("mongoose");

// OPTIONAL: falls du Models hast
const User = require("../src/models/User");
const Gespraech = require("../src/models/Gespraech");
const KlientenAkte = require("../src/models/Klientenakte");

require("dotenv").config({ path: ".env.test" });

beforeAll(async () => {
    await mongoose.connect(process.env.MONGODB_URI);
});

beforeEach(async () => {
    // DB komplett leeren
    await User.deleteMany({});
    await Gespraech.deleteMany({});
    await KlientenAkte.deleteMany({});
});

afterAll(async () => {
    await mongoose.connection.close();
});

describe("Gespraeche API (MongoDB)", () => {

    test("GET /api/gespraeche/:klientenAkteId without login should return 401", async () => {
        const response = await request(app).get("/api/gespraeche/1");

        expect(response.statusCode).toBe(401);
        expect(response.body.error).toBe("Nicht eingeloggt");
    });

    test("POST and GET /api/gespraeche should work for own klientenAkte", async () => {
        const agent = request.agent(app);

        // Register
        await agent.post("/api/auth/register").send({
            email: "gespraech1@test.at",
            password: "123456",
            registerNr: "REG_GESP_1",
        });

        // Login
        await agent.post("/api/auth/login").send({
            email: "gespraech1@test.at",
            password: "123456",
        });

        // Klientenakte
        const akteResponse = await agent.post("/api/klientenAkten").send({});
        const klientenAkteId = akteResponse.body.id;

expect(klientenAkteId).toBeDefined();

        // Gespräch erstellen
        const createRes = await agent.post("/api/gespraeche").send({
            klientenAkteId,
            datum: "2026-04-04",
            formMetaData: { version: 1 },
            assessment: { gewicht: 85 },
            diagnosen: { hauptdiagnose: "Adipositas" },
            ziele: { ziel1: "Gewichtsreduktion" },
            outcome: { status: "offen" },
            notizen: "Erstgespräch",
        });

        expect(createRes.statusCode).toBe(201);

        // GET
        const getRes = await agent.get(`/api/gespraeche/${klientenAkteId}`);

        expect(getRes.statusCode).toBe(200);
        expect(getRes.body.length).toBe(1);

        const gespraech = getRes.body[0];

        expect(gespraech.assessment.gewicht).toBe(85);
        expect(gespraech.diagnosen.hauptdiagnose).toBe("Adipositas");
    });

    test("DELETE /api/gespraeche/:id should delete own gespraech", async () => {
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

        const akteRes = await agent.post("/api/klientenAkten").send({});
        const klientenAkteId = akteRes.body.id;

        const createRes = await agent.post("/api/gespraeche").send({
            klientenAkteId,
            datum: "2026-04-05",
            notizen: "Zu löschen",
        });

        const gespraechId = createRes.body.id;

        const deleteRes = await agent.delete(`/api/gespraeche/${gespraechId}`);

        expect(deleteRes.statusCode).toBe(204);

        const getRes = await agent.get(`/api/gespraeche/${klientenAkteId}`);

        expect(getRes.body.length).toBe(0);
    });

    test("GET foreign klientenAkte should return 403", async () => {
        const agentA = request.agent(app);
        const agentB = request.agent(app);

        // User A
        await agentA.post("/api/auth/register").send({
            email: "owner@test.at",
            password: "123456",
            registerNr: "REG_OWNER",
        });

        await agentA.post("/api/auth/login").send({
            email: "owner@test.at",
            password: "123456",
        });

        const akteRes = await agentA.post("/api/klientenAkten").send({});
        const klientenAkteId = akteRes.body.id;

        // User B
        await agentB.post("/api/auth/register").send({
            email: "intruder@test.at",
            password: "123456",
            registerNr: "REG_INTRUDER",
        });

        await agentB.post("/api/auth/login").send({
            email: "intruder@test.at",
            password: "123456",
        });

        const res = await agentB.get(`/api/gespraeche/${klientenAkteId}`);

        expect(res.statusCode).toBe(403);
    });

    test("PUT should update JSON fields", async () => {
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

        const akteRes = await agent.post("/api/klientenAkten").send({});
        const klientenAkteId = akteRes.body.id;

        const createRes = await agent.post("/api/gespraeche").send({
            klientenAkteId,
            datum: "2026-04-04",
            assessment: { motivation: "hoch" }
        });

        const gespraechId = createRes.body.id;

        await agent.put("/api/gespraeche").send({
            id: gespraechId,
            klientenAkteId,
            datum: "2026-04-05",
            assessment: { motivation: "niedrig" }
        });

        const getRes = await agent.get(`/api/gespraeche/${klientenAkteId}`);

        expect(getRes.body[0].assessment.motivation).toBe("niedrig");
    });

    test("POST should allow null JSON fields", async () => {
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

        const akteRes = await agent.post("/api/klientenAkten").send({});
        const klientenAkteId = akteRes.body.id;

        const res = await agent.post("/api/gespraeche").send({
            klientenAkteId,
            datum: "2026-04-04",
            assessment: null
        });

        expect(res.statusCode).toBe(201);
        expect(res.body.assessment).toBeNull();
    });
});