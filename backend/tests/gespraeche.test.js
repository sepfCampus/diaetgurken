const request = require("supertest");
const app = require("../src/app");
const prisma = require("../src/db/prismaClient");

beforeEach(async () => {
    await prisma.user.deleteMany();
});

afterAll(async () => {
    await prisma.$disconnect();
});

describe("Gespraeche API (MongoDB)", () => {

    test("GET /api/gespraeche/:klientenAkteId without login should return 401", async () => {
        const response = await request(app).get("/api/gespraeche/1");

        expect(response.statusCode).toBe(401);
        expect(response.body.error).toBe("Nicht eingeloggt");
    });

    test("POST and GET /api/gespraeche should work for own klientenAkte", async () => {
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

        expect(loginResponse.statusCode).toBe(200);

        // 3. Klientenakte anlegen
        const akteResponse = await agent.post("/api/users/klientenakte").send({});

        expect(akteResponse.statusCode).toBe(201);
        expect(akteResponse.body.id).toBeDefined();

        const akteResponse = await agent.post("/api/klientenAkten").send({});
        const klientenAkteId = akteResponse.body.id;

        expect(klientenAkteId).toBeDefined();

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
            passwort: "123456",
            registerNr: "REG_GESP_2",
        });

        await agent.post("/api/auth/login").send({
            email: "gespraech2@test.at",
            passwort: "123456",
            registerNr: "REG_GESP_2",
        });

        // 3. Klientenakte anlegen
        const akteResponse = await agent.post("/api/users/klientenakte").send({});

        expect(akteResponse.statusCode).toBe(201);
        const klientenAkteId = akteResponse.body.id;
        const akteRes = await agent.post("/api/klientenAkten").send({});
        const klientenAkteId = akteRes.body.id;

        // 4. Gespräch anlegen
        const createGespraechResponse = await agent
            .post(`/api/users/klientenakten/${klientenAkteId}/gespraech`)
            .send({
                datum: "2026-04-05",
                formMetaData: { version: 1 },
                assessment: { gewicht: 80 },
                notizen: "Zu löschen",
            });
        const createRes = await agent.post("/api/gespraeche").send({
            klientenAkteId,
            datum: "2026-04-05",
            notizen: "Zu löschen",
        });

        expect(createGespraechResponse.statusCode).toBe(201);
        const gespraechId = createGespraechResponse.body.id;
        const gespraechId = createRes.body.id;

        // 5. Gespräch löschen
        const deleteResponse = await agent.delete(`/api/users/klientenakten/${klientenAkteId}/gespraech/${gespraechId}`);
        const deleteRes = await agent.delete(`/api/gespraeche/${gespraechId}`);
        expect(deleteRes.statusCode).toBe(204);

        // 6. Prüfen, ob Liste leer ist
        const getResponse = await agent.get(`/api/users/klientenakten/${klientenAkteId}/gespraeche`);
        const getRes = await agent.get(`/api/gespraeche/${klientenAkteId}`);
        expect(getRes.body.length).toBe(0);
    });

    test("GET foreign klientenAkte should return 403", async () => {
        const agentA = request.agent(app);
        const agentB = request.agent(app);

        await agentA.post("/api/auth/register").send({
            email: "owner@test.at",
            passwort: "123456",
            registerNr: "REG_OWNER",
        });
        await agentA.post("/api/auth/login").send({
            email: "owner@test.at",
            passwort: "123456",
            registerNr: "REG_OWNER",
        });

        // User A erstellt Klientenakte
        const akteResponse = await agentA.post("/api/users/klientenakte").send({});
        expect(akteResponse.statusCode).toBe(201);
        const akteRes = await agentA.post("/api/klientenAkten").send({});
        const klientenAkteId = akteRes.body.id;

        await agentB.post("/api/auth/register").send({
            email: "intruder@test.at",
            passwort: "123456",
            registerNr: "REG_INTRUDER",
        });
        await agentB.post("/api/auth/login").send({
            email: "intruder@test.at",
            passwort: "123456",
            registerNr: "REG_INTRUDER",
        });

        // User B versucht Gespräche von User A abzurufen
        const response = await agentB.get(`/api/users/klientenakten/${klientenAkteId}/gespraeche`);
        const res = await agentB.get(`/api/gespraeche/${klientenAkteId}`);

        expect(res.statusCode).toBe(403);
    });

    test("PUT /api/users/klientenakten/:klientenAkteId/gespraech/:id should return 403 for updating foreign gespraech", async () => {
        const agentA = request.agent(app);
        const agentB = request.agent(app);

        // User A registrieren
        await agentA.post("/api/auth/register").send({
            email: "owner@test.at",
            passwort: "123456",
            registerNr: "REG_OWNER",
        });

        // User A einloggen
        await agentA.post("/api/auth/login").send({
            email: "owner@test.at",
            passwort: "123456",
            registerNr: "REG_OWNER",
        });

        // User A erstellt Klientenakte
        const akteResponse = await agentA.post("/api/users/klientenakte").send({});
        expect(akteResponse.statusCode).toBe(201);

        const klientenAkteId = akteResponse.body.id;

        // User A erstellt Gespräch
        const createGespraechResponse = await agentA
            .post(`/api/users/klientenakten/${klientenAkteId}/gespraech`)
            .send({
                datum: "2026-04-05",
                notizen: "Zu aktualisieren",
            });
        const gespraechId = createGespraechResponse.body.id;

        // User B registrieren
        await agentB.post("/api/auth/register").send({
            email: "intruder@test.at",
            passwort: "123456",
            registerNr: "REG_INTRUDER",
        });

        // User B einloggen
        await agentB.post("/api/auth/login").send({
            email: "intruder@test.at",
            passwort: "123456",
            registerNr: "REG_INTRUDER",
        });

        // User B versucht Gespräch von User A zu aktualisieren
        const response = await agentB.put(`/api/users/klientenakten/${klientenAkteId}/gespraech/${gespraechId}`).send({
            datum: "2026-04-06",
            notizen: "Von Intruder aktualisiert",
        });

        expect(response.statusCode).toBe(403);
    });

    test("GET /api/users/klientenakten/:klientenAkteId/gespraeche should return 404 for non-existing klientenAkte", async () => {
        const agent = request.agent(app);

        // 1. User registrieren
        const registerResponse = await agent
            .post("/api/auth/register")
            .send({
                email: "gespraech404@test.at",
                passwort: "123456",
                registerNr: "REG_GESP_404",
            });

        expect(registerResponse.statusCode).toBe(201);

        // 2. Login
        const loginResponse = await agent
            .post("/api/auth/login")
            .send({
                email: "gespraech404@test.at",
                passwort: "123456",
                registerNr: "REG_GESP_404",
            });

        expect(loginResponse.statusCode).toBe(200);

        // 3. Nicht existierende Klientenakte abrufen
        const response = await agent.get("/api/users/klientenakten/9999/gespraeche");

        expect(response.statusCode).toBe(404);
    });

    test("PUT /api/users/klientenakten/:klientenAkteId/gespraech/:id should update JSON fields", async () => {
        const agent = request.agent(app);

        // User + Login
        await agent.post("/api/auth/register").send({
            email: "update@test.at",
            passwort: "123456",
            registerNr: "REG_UPDATE",
        });
        await agent.post("/api/auth/login").send({
            email: "update@test.at",
            passwort: "123456",
            registerNr: "REG_UPDATE",
        });

        // Klientenakte erstellen
        const akteRes = await agent.post("/api/users/klientenakte").send({});
        expect(akteRes.statusCode).toBe(201);
        const klientenAkteId = akteRes.body.id;

        // Gespräch erstellen
        const createRes = await agent
            .post(`/api/users/klientenakten/${klientenAkteId}/gespraech`)
            .send({
                datum: "2026-04-04",
                assessment: { motivation: "hoch" },
            });
        expect(createRes.statusCode).toBe(201);
        const gespraechId = createRes.body.id;

        // UPDATE
        const updateRes = await agent
            .put(`/api/users/klientenakten/${klientenAkteId}/gespraech/${gespraechId}`)
            .send({
                datum: "2026-04-05",
                assessment: { motivation: "niedrig" },
            });

        expect(updateRes.statusCode).toBe(200);

        // GET prüfen
        const getRes = await agent.get(`/api/users/klientenakten/${klientenAkteId}/gespraeche`);
        expect(getRes.statusCode).toBe(200);
        expect(getRes.body[0].assessment.motivation).toBe("niedrig");
    });

    test("POST should allow null JSON fields", async () => {
        const agent = request.agent(app);

        await agent.post("/api/auth/register").send({
            email: "null@test.at",
            passwort: "123456",
            registerNr: "REG_NULL",
        });
        await agent.post("/api/auth/login").send({
            email: "null@test.at",
            passwort: "123456",
            registerNr: "REG_NULL",
        });

        const akteRes = await agent.post("/api/users/klientenakte").send({});
        const klientenAkteId = akteRes.body.id;

        const res = await agent.post(`/api/users/klientenakten/${klientenAkteId}/gespraech`).send({
            datum: "2026-04-04",
            assessment: null,
        });

        expect(res.statusCode).toBe(201);
        expect(res.body.assessment).toBeNull();
    });
});
