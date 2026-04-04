const request = require("supertest");
const app = require("../src/app");

describe("Users API", () => {
    test("DELETE /api/users should delete current user and destroy session", async () => {
        const agent = request.agent(app);

        // 1. User registrieren
        const registerResponse = await agent
            .post("/api/auth/register")
            .send({
                email: "deleteuser@test.at",
                password: "123456",
                registerNr: "REG_DELETE_1",
            });

        expect(registerResponse.statusCode).toBe(201);

        // 2. Login
        const loginResponse = await agent
            .post("/api/auth/login")
            .send({
                email: "deleteuser@test.at",
                password: "123456",
            });

        expect(loginResponse.statusCode).toBe(200);

        // 3. User löschen
        const deleteResponse = await agent.delete("/api/users");

        expect(deleteResponse.statusCode).toBe(204);

        // 4. Prüfen, dass Session weg ist
        const whoamiResponse = await agent.get("/api/auth/whoami");

        expect(whoamiResponse.statusCode).toBe(401);
        expect(whoamiResponse.body.error).toBe("Nicht eingeloggt");
    });
});