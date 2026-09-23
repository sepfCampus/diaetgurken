const request = require("supertest");
const app = require("../src/app");
const prisma = require("../src/db/prismaClient");

beforeEach(async () => {
    await prisma.user.deleteMany();
});

afterAll(async () => {
    await prisma.$disconnect();
});

describe("Users API", () => {
    test("DELETE /api/users sollte User und Session löschen", async () => {
        const agent = request.agent(app);

        await agent.post("/api/auth/register").send({
            email: "deleteuser@test.at",
            passwort: "123456",
            registerNr: "REG_DELETE_1",
        });

        await agent.post("/api/auth/login").send({
            email: "deleteuser@test.at",
            passwort: "123456",
            registerNr: "REG_DELETE_1",
        });

        const deleteResponse = await agent.delete("/api/users");
        expect(deleteResponse.statusCode).toBe(204);

        const whoamiResponse = await agent.get("/api/auth/whoami");
        expect(whoamiResponse.statusCode).toBe(401);
        expect(whoamiResponse.body.error).toBe("Nicht eingeloggt");

        const userInDb = await prisma.user.findUnique({
            where: { email: "deleteuser@test.at" },
        });
        expect(userInDb).toBeNull();
    });

    test("DELETE /api/users ohne Login sollte 401 zurückgeben", async () => {
        const response = await request(app).delete("/api/users");
        expect(response.statusCode).toBe(401);
    });
});
