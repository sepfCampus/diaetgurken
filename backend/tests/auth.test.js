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

describe("Auth API", () => {
    test("POST /api/auth/register should create a user", async () => {
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
    });
});