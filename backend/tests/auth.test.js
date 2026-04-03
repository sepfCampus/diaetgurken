const request = require("supertest");
const app = require("../src/app");

describe("Auth API", () => {
    test("POST /api/auth/register should create a user", async () => {
        const response = await request(app)
            .post("/api/auth/register")
            .send({
                email: "test@test.at",
                password: "123456",
                registerNr: "REG001",
            });

        expect(response.statusCode).toBe(201);
        expect(response.body.email).toBe("test@test.at");
        expect(response.body.registerNr).toBe("REG001");
        expect(response.body.id).toBeDefined();
    });
});