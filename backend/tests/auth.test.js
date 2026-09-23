const request = require("supertest");
const app = require("../src/app");
const prisma = require("../src/db/prismaClient");

beforeEach(async () => {
    await prisma.user.deleteMany();
});

afterAll(async () => {
    await prisma.$disconnect();
});

describe("Auth API", () => {
    test("POST /api/auth/register sollte einen User erstellen", async () => {
        const response = await request(app)
            .post("/api/auth/register")
            .send({
                email: "test@test.at",
                passwort: "123456",
                registerNr: "REG001",
            });

        expect(response.statusCode).toBe(201);
        expect(response.body.email).toBe("test@test.at");
        expect(response.body.registerNr).toBe("REG001");
        expect(response.body.id).toBeDefined();
        expect(response.body.passwordHash).toBeUndefined();
    });

    test("POST /api/auth/register sollte 400 bei fehlenden Feldern zurückgeben", async () => {
        const response = await request(app)
            .post("/api/auth/register")
            .send({ email: "test@test.at" });

        expect(response.statusCode).toBe(400);
    });

    test("POST /api/auth/register sollte 409 bei doppelter E-Mail zurückgeben", async () => {
        await request(app).post("/api/auth/register").send({
            email: "doppelt@test.at",
            passwort: "123456",
            registerNr: "REG001",
        });

        const response = await request(app).post("/api/auth/register").send({
            email: "doppelt@test.at",
            passwort: "abcdef",
            registerNr: "REG002",
        });

        expect(response.statusCode).toBe(409);
    });

    test("POST /api/auth/login sollte Session setzen und Userdaten zurückgeben", async () => {
        const agent = request.agent(app);

        await agent.post("/api/auth/register").send({
            email: "login@test.at",
            passwort: "123456",
            registerNr: "REG_LOGIN",
        });

        const loginResponse = await agent.post("/api/auth/login").send({
            email: "login@test.at",
            passwort: "123456",
            registerNr: "REG_LOGIN",
        });

        expect(loginResponse.statusCode).toBe(200);
        expect(loginResponse.body.email).toBe("login@test.at");
        expect(loginResponse.body.passwordHash).toBeUndefined();

        const whoamiResponse = await agent.get("/api/auth/whoami");
        expect(whoamiResponse.statusCode).toBe(200);
        expect(whoamiResponse.body.email).toBe("login@test.at");
    });

    test("POST /api/auth/login mit falschem Passwort sollte 401 zurückgeben", async () => {
        await request(app).post("/api/auth/register").send({
            email: "wrong@test.at",
            passwort: "123456",
            registerNr: "REG_WRONG",
        });

        const response = await request(app).post("/api/auth/login").send({
            email: "wrong@test.at",
            passwort: "falschespasswort",
            registerNr: "REG_WRONG",
        });

        expect(response.statusCode).toBe(401);
    });

    test("POST /api/auth/login mit unbekannter E-Mail sollte 401 zurückgeben", async () => {
        const response = await request(app).post("/api/auth/login").send({
            email: "unbekannt@test.at",
            passwort: "123456",
            registerNr: "REG_UNKNOWN",
        });

        expect(response.statusCode).toBe(401);
    });

    test("GET /api/auth/whoami ohne Login sollte 401 zurückgeben", async () => {
        const response = await request(app).get("/api/auth/whoami");
        expect(response.statusCode).toBe(401);
        expect(response.body.error).toBe("Nicht eingeloggt");
    });

    test("POST /api/auth/logout sollte Session zerstören", async () => {
        const agent = request.agent(app);

        await agent.post("/api/auth/register").send({
            email: "logout@test.at",
            passwort: "123456",
            registerNr: "REG_LOGOUT",
        });

        await agent.post("/api/auth/login").send({
            email: "logout@test.at",
            passwort: "123456",
            registerNr: "REG_LOGOUT",
        });

        const logoutResponse = await agent.post("/api/auth/logout");
        expect(logoutResponse.statusCode).toBe(200);

        const whoamiResponse = await agent.get("/api/auth/whoami");
        expect(whoamiResponse.statusCode).toBe(401);
    });
});
