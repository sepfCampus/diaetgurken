const request = require("supertest");
const app = require("../src/app");
const mongoose = require("mongoose");
const User = require("../src/models/User");

require("dotenv").config({ path: ".env.test" });

beforeAll(async () => {
    await mongoose.connect(process.env.MONGODB_URI);
});

beforeEach(async () => {
    await User.deleteMany(); // DB leeren
});

afterAll(async () => {
    await mongoose.connection.close();
});

describe("Auth API (MongoDB)", () => {
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

        // optional: prüfen ob wirklich in DB gespeichert
        const userInDb = await User.findOne({ email: "test@test.at" });
        expect(userInDb).not.toBeNull();
    });
});