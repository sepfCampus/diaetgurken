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

describe("Gespraeche API", () => {
    test("GET /api/gespraeche/:klientenAkteId without login should return 401", async () => {
        const response = await request(app).get("/api/gespraeche/1");

        expect(response.statusCode).toBe(401);
        expect(response.body.error).toBe("Nicht eingeloggt");
    });

    test("POST and GET /api/gespraeche should work for own klientenAkte", async () => {
        const agent = request.agent(app);

        // 1. User registrieren
        const registerResponse = await agent
            .post("/api/auth/register")
            .send({
                email: "gespraech1@test.at",
                password: "123456",
                registerNr: "REG_GESP_1",
            });

        expect(registerResponse.statusCode).toBe(201);

        // 2. Login
        const loginResponse = await agent
            .post("/api/auth/login")
            .send({
                email: "gespraech1@test.at",
                password: "123456",
            });

        expect(loginResponse.statusCode).toBe(200);

        // 3. Klientenakte anlegen
        const akteResponse = await agent.post("/api/klientenAkten").send({});

        expect(akteResponse.statusCode).toBe(201);
        expect(akteResponse.body.id).toBeDefined();

        const klientenAkteId = akteResponse.body.id;

        // 4. Gespräch anlegen
        const createGespraechResponse = await agent
            .post("/api/gespraeche")
            .send({
                klientenAkteId,
                datum: "2026-04-04",
                formMetaData: { version: 1 },
                assessment: { gewicht: 85 },
                diagnosen: { hauptdiagnose: "Adipositas" },
                ziele: { ziel1: "Gewichtsreduktion" },
                outcome: { status: "offen" },
                notizen: "Erstgespräch",
            });

        expect(createGespraechResponse.statusCode).toBe(201);
        expect(createGespraechResponse.body.id).toBeDefined();
        expect(createGespraechResponse.body.klientenAkteId).toBe(klientenAkteId);

        // 5. Gespräche der Akte laden
        const getGespraecheResponse = await agent.get(`/api/gespraeche/${klientenAkteId}`);

        expect(getGespraecheResponse.statusCode).toBe(200);
        expect(Array.isArray(getGespraecheResponse.body)).toBe(true);
        expect(getGespraecheResponse.body.length).toBe(1);
        expect(getGespraecheResponse.body[0].klientenAkteId).toBe(klientenAkteId);
        expect(getGespraecheResponse.body[0].datum.startsWith("2026-04-04")).toBe(true);

        const gespraech = getGespraecheResponse.body[0];

        expect(gespraech.formMetaData.version).toBe(1);
        expect(gespraech.assessment.gewicht).toBe(85);
        expect(gespraech.diagnosen.hauptdiagnose).toBe("Adipositas");
        expect(gespraech.ziele.ziel1).toBe("Gewichtsreduktion");
        expect(gespraech.outcome.status).toBe("offen");
    });

    test("DELETE /api/gespraeche/:id should delete own gespraech", async () => {
        const agent = request.agent(app);

        // 1. User registrieren
        await agent.post("/api/auth/register").send({
            email: "gespraech2@test.at",
            password: "123456",
            registerNr: "REG_GESP_2",
        });

        // 2. Login
        await agent.post("/api/auth/login").send({
            email: "gespraech2@test.at",
            password: "123456",
        });

        // 3. Klientenakte anlegen
        const akteResponse = await agent.post("/api/klientenAkten").send({});
        const klientenAkteId = akteResponse.body.id;

        // 4. Gespräch anlegen
        const createGespraechResponse = await agent.post("/api/gespraeche").send({
            klientenAkteId,
            datum: "2026-04-05",
            notizen: "Zu löschen",
        });

        const gespraechId = createGespraechResponse.body.id;

        // 5. Gespräch löschen
        const deleteResponse = await agent.delete(`/api/gespraeche/${gespraechId}`);

        expect(deleteResponse.statusCode).toBe(204);

        // 6. Prüfen, ob Liste leer ist
        const getResponse = await agent.get(`/api/gespraeche/${klientenAkteId}`);

        expect(getResponse.statusCode).toBe(200);
        expect(Array.isArray(getResponse.body)).toBe(true);
        expect(getResponse.body.length).toBe(0);
    });

    test("GET /api/gespraeche/:klientenAkteId should return 403 for foreign klientenAkte", async () => {
        const agentA = request.agent(app);
        const agentB = request.agent(app);

        // User A registrieren
        await agentA.post("/api/auth/register").send({
            email: "owner@test.at",
            password: "123456",
            registerNr: "REG_OWNER",
        });

        // User A einloggen
        await agentA.post("/api/auth/login").send({
            email: "owner@test.at",
            password: "123456",
        });

        // User A erstellt Klientenakte
        const akteResponse = await agentA.post("/api/klientenAkten").send({});
        expect(akteResponse.statusCode).toBe(201);

        const klientenAkteId = akteResponse.body.id;

        // User B registrieren
        await agentB.post("/api/auth/register").send({
            email: "intruder@test.at",
            password: "123456",
            registerNr: "REG_INTRUDER",
        });

        // User B einloggen
        await agentB.post("/api/auth/login").send({
            email: "intruder@test.at",
            password: "123456",
        });

        // User B versucht Gespräche von User A abzurufen
        const response = await agentB.get(`/api/gespraeche/${klientenAkteId}`);

        expect(response.statusCode).toBe(403);
        expect(response.body.error).toBe("Kein Zugriff auf diese Klientenakte");
    });

    test("PUT /api/gespraeche/:klientenAkteId should return 403 for updating foreign gespraech", async () => {
        const agentA = request.agent(app);
        const agentB = request.agent(app);

        // User A registrieren
        await agentA.post("/api/auth/register").send({
            email: "owner@test.at",
            password: "123456",
            registerNr: "REG_OWNER",
        });

        // User A einloggen
        await agentA.post("/api/auth/login").send({
            email: "owner@test.at",
            password: "123456",
        });

        // User A erstellt Klientenakte
        const akteResponse = await agentA.post("/api/klientenAkten").send({});
        expect(akteResponse.statusCode).toBe(201);

        const klientenAkteId = akteResponse.body.id;

        // User A erstellt Gespräch
        const createGespraechResponse = await agentA.post("/api/gespraeche").send({
            klientenAkteId,
            datum: "2026-04-05",
            notizen: "Zu aktualisieren",
        });
        const gespraechId = createGespraechResponse.body.id;

        // User B registrieren
        await agentB.post("/api/auth/register").send({
            email: "intruder@test.at",
            password: "123456",
            registerNr: "REG_INTRUDER",
        });

        // User B einloggen
        await agentB.post("/api/auth/login").send({
            email: "intruder@test.at",
            password: "123456",
        });

        // User B versucht Gespräch von User A zu aktualisieren
        const response = await agentB.put("/api/gespraeche").send({
            id: gespraechId,
            klientenAkteId,
            datum: "2026-04-06",
            notizen: "Von Intruder aktualisiert",
        });

        expect(response.statusCode).toBe(403);
        expect(response.body.error).toBe("Kein Zugriff auf diese Klientenakte");
    });

    test("GET /api/gespraeche/:klientenAkteId should return 404 for non-existing klientenAkte", async () => {
        const agent = request.agent(app);

        // 1. User registrieren
        const registerResponse = await agent
            .post("/api/auth/register")
            .send({
                email: "gespraech404@test.at",
                password: "123456",
                registerNr: "REG_GESP_404",
            });

        expect(registerResponse.statusCode).toBe(201);

        // 2. Login
        const loginResponse = await agent
            .post("/api/auth/login")
            .send({
                email: "gespraech404@test.at",
                password: "123456",
            });

        expect(loginResponse.statusCode).toBe(200);

        // 3. Nicht existierende Klientenakte abrufen
        const response = await agent.get("/api/gespraeche/9999");

        expect(response.statusCode).toBe(404);
        expect(response.body.error).toBe("Klientenakte nicht gefunden");
    });

    test("PUT /api/gespraeche should update JSON fields", async () => {
        const agent = request.agent(app);

        // User + Login
        await agent.post("/api/auth/register").send({
            email: "update@test.at",
            password: "123456",
            registerNr: "REG_UPDATE",
        });

        await agent.post("/api/auth/login").send({
            email: "update@test.at",
            password: "123456",
        });

        // Klientenakte
        const akteRes = await agent.post("/api/klientenAkten").send({});
        const klientenAkteId = akteRes.body.id;

        // Gespräch erstellen
        const createRes = await agent.post("/api/gespraeche").send({
            klientenAkteId,
            datum: "2026-04-04",
            assessment: { motivation: "hoch" }
        });

        const gespraechId = createRes.body.id;

        // UPDATE
        const updateRes = await agent.put("/api/gespraeche").send({
            id: gespraechId,
            klientenAkteId,
            datum: "2026-04-05",
            assessment: { motivation: "niedrig" }
        });

        expect(updateRes.statusCode).toBe(200);

        // GET prüfen
        const getRes = await agent.get(`/api/gespraeche/${klientenAkteId}`);

        const updated = getRes.body[0];

        expect(updated.assessment.motivation).toBe("niedrig");
        expect(updated.datum.startsWith("2026-04-05")).toBe(true);
    });

    test("POST /api/gespraeche should allow null JSON fields", async () => {
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