const express = require("express");
const session = require("express-session");
const request = require("supertest");

jest.mock("../src/db/prismaClient", () => ({}));
jest.mock("../src/repositories/prisma/klientenAkteRepositoryPrisma", () => ({
    findOwnerById: jest.fn(),
}));
jest.mock("../src/repositories/prisma/gespraechRepositoryPrisma", () => ({
    findForSummaryByAkteId: jest.fn(),
}));

const aktenRepository = require("../src/repositories/prisma/klientenAkteRepositoryPrisma");
const gespraecheRepository = require("../src/repositories/prisma/gespraechRepositoryPrisma");
const { createSummaryService } = require("../src/services/summaryService");
const mockLLMProvider = require("../src/services/summary/providers/mockLLMProvider");
const apiRoutes = require("../src/routes/api");
const errorHandler = require("../src/middlewares/errorHandler");

const gespraeche = [
    {
        id: 10,
        datum: new Date("2026-01-10T00:00:00.000Z"),
        assessment: { gewicht: 80 },
        diagnosen: null,
        ziele: { bewegung: "dreimal wöchentlich spazieren" },
        outcome: { status: "offen" },
        notizen: "Erfundenes Erstgespräch",
        formMetaData: { internal: true },
        selectedFilters: ["intern"],
    },
    {
        id: 11,
        datum: new Date("2026-02-10T00:00:00.000Z"),
        assessment: { gewicht: 79 },
        diagnosen: null,
        ziele: null,
        outcome: { bewegung: "zweimal wöchentlich" },
        notizen: "Erfundenes Folgegespräch",
    },
];

function testApp() {
    const app = express();
    app.use(express.json());
    app.use(session({
        secret: "synthetic-test-session-secret",
        resave: false,
        saveUninitialized: false,
    }));
    app.post("/test-login/:userId", (req, res) => {
        req.session.userId = Number(req.params.userId);
        res.sendStatus(204);
    });
    app.use("/api", apiRoutes);
    app.use(errorHandler);
    return app;
}

beforeEach(() => {
    jest.clearAllMocks();
    aktenRepository.findOwnerById.mockResolvedValue({ id: 3, userId: 7 });
    gespraecheRepository.findForSummaryByAkteId.mockResolvedValue(gespraeche);
    jest.spyOn(console, "error").mockImplementation(() => {});
});

afterEach(() => {
    jest.restoreAllMocks();
    delete process.env.LLM_PROVIDER;
    delete process.env.OLLAMA_BASE_URL;
    delete process.env.OLLAMA_MODEL;
    delete process.env.OLLAMA_TIMEOUT_MS;
});

describe("SummaryService", () => {
    test("prüft die Akte und übergibt nur ausgewählte Gesprächsfelder an den Provider", async () => {
        const provider = {
            name: "test",
            summarize: jest.fn().mockResolvedValue({
                summary: "Erfundener Testtext",
                development: "",
                currentGoals: [],
                openPoints: [],
                ignored: "wird nicht ausgegeben",
            }),
        };
        const service = createSummaryService({
            aktenRepository,
            gespraecheRepository,
            provider,
        });

        const result = await service.summarizeForCurrentUser("3", { userId: 7 });

        expect(aktenRepository.findOwnerById).toHaveBeenCalledWith(3);
        expect(gespraecheRepository.findForSummaryByAkteId).toHaveBeenCalledWith(3);
        expect(provider.summarize).toHaveBeenCalledWith([
            {
                id: 10,
                datum: "2026-01-10",
                assessment: { gewicht: 80 },
                diagnosen: null,
                ziele: { bewegung: "dreimal wöchentlich spazieren" },
                outcome: { status: "offen" },
                notizen: "Erfundenes Erstgespräch",
            },
            {
                id: 11,
                datum: "2026-02-10",
                assessment: { gewicht: 79 },
                diagnosen: null,
                ziele: null,
                outcome: { bewegung: "zweimal wöchentlich" },
                notizen: "Erfundenes Folgegespräch",
            },
        ], {});
        expect(result).toEqual({
            summary: {
                summary: "Erfundener Testtext",
                development: "",
                currentGoals: [],
                openPoints: [],
            },
            metadata: { provider: "test", sourceCount: 2, latencyMs: expect.any(Number) },
            reviewRequired: true,
        });
    });

    test("der Mock macht keine medizinischen Aussagen", async () => {
        expect(await mockLLMProvider.summarize(gespraeche)).toEqual({
            summary: "Testausgabe: 2 dokumentierte Gespräche vorhanden.",
            development: "",
            currentGoals: [],
            openPoints: [],
        });
    });

    test("weist eine ungültige Provider-Antwort zurück", async () => {
        const service = createSummaryService({
            aktenRepository,
            gespraecheRepository,
            provider: { name: "test", summarize: async () => ({ summary: "nur ein Feld" }) },
        });
        await expect(service.summarizeForCurrentUser("3", { userId: 7 }))
            .rejects.toMatchObject({ status: 502 });
    });

    test("meldet einen Provider-Ausfall ohne dessen Fehlermeldung weiterzugeben", async () => {
        const service = createSummaryService({
            aktenRepository,
            gespraecheRepository,
            provider: { name: "test", summarize: async () => { throw new Error("private Eingabe"); } },
        });
        await expect(service.summarizeForCurrentUser("3", { userId: 7 }))
            .rejects.toMatchObject({ status: 503, message: "Zusammenfassungsdienst nicht verfügbar" });
    });

    test("ruft den Provider für eine fremde Akte nicht auf", async () => {
        const provider = { name: "test", summarize: jest.fn() };
        const service = createSummaryService({ aktenRepository, gespraecheRepository, provider });
        await expect(service.summarizeForCurrentUser("3", { userId: 8 }))
            .rejects.toMatchObject({ status: 403 });
        expect(gespraecheRepository.findForSummaryByAkteId).not.toHaveBeenCalled();
        expect(provider.summarize).not.toHaveBeenCalled();
    });
});

describe("Summary API", () => {
    test("fordert eine Anmeldung", async () => {
        const response = await request(testApp()).post("/api/users/klientenakten/3/summary");
        expect(response.status).toBe(401);
        expect(aktenRepository.findOwnerById).not.toHaveBeenCalled();
    });

    test("liefert die strukturierte Mock-Antwort für eine eigene Akte", async () => {
        const agent = request.agent(testApp());
        await agent.post("/test-login/7").expect(204);
        const response = await agent.post("/api/users/klientenakten/3/summary");
        expect(response.status).toBe(200);
        expect(response.body).toEqual({
            summary: {
                summary: "Testausgabe: 2 dokumentierte Gespräche vorhanden.",
                development: "",
                currentGoals: [],
                openPoints: [],
            },
            metadata: { provider: "mock", sourceCount: 2, latencyMs: expect.any(Number) },
            reviewRequired: true,
        });
    });

    test.each([
        ["fremde Akte", { id: 3, userId: 8 }, 403],
        ["fehlende Akte", null, 404],
    ])("meldet %s", async (label, akte, status) => {
        aktenRepository.findOwnerById.mockResolvedValue(akte);
        const agent = request.agent(testApp());
        await agent.post("/test-login/7").expect(204);
        await agent.post("/api/users/klientenakten/3/summary").expect(status);
        expect(gespraecheRepository.findForSummaryByAkteId).not.toHaveBeenCalled();
    });

    test("weist eine ungültige Akten-ID zurück", async () => {
        const agent = request.agent(testApp());
        await agent.post("/test-login/7").expect(204);
        await agent.post("/api/users/klientenakten/abc/summary").expect(400);
    });

    test("meldet fehlende Gespräche", async () => {
        gespraecheRepository.findForSummaryByAkteId.mockResolvedValue([]);
        const agent = request.agent(testApp());
        await agent.post("/test-login/7").expect(204);
        await agent.post("/api/users/klientenakten/3/summary").expect(422);
    });

    test("meldet eine nicht unterstützte Provider-Konfiguration", async () => {
        process.env.LLM_PROVIDER = "nicht-vorhanden";
        const agent = request.agent(testApp());
        await agent.post("/test-login/7").expect(204);
        const response = await agent.post("/api/users/klientenakten/3/summary");
        expect(response.status).toBe(503);
        expect(response.body.error).toBe("Zusammenfassungsdienst nicht verfügbar");
    });

    test("meldet einen Provider-Ausfall als kontrollierten API-Fehler", async () => {
        jest.spyOn(mockLLMProvider, "summarize").mockRejectedValue(new Error("private Eingabe"));
        const agent = request.agent(testApp());
        await agent.post("/test-login/7").expect(204);
        const response = await agent.post("/api/users/klientenakten/3/summary");
        expect(response.status).toBe(503);
        expect(response.body).toEqual({ error: "Zusammenfassungsdienst nicht verfügbar" });
    });

    test("meldet eine ungültige Provider-Antwort als API-Fehler", async () => {
        jest.spyOn(mockLLMProvider, "summarize").mockResolvedValue({ summary: "unvollständig" });
        const agent = request.agent(testApp());
        await agent.post("/test-login/7").expect(204);
        const response = await agent.post("/api/users/klientenakten/3/summary");
        expect(response.status).toBe(502);
        expect(response.body).toEqual({ error: "Ungültige Antwort des Zusammenfassungsdienstes" });
    });

    test("verwendet den konfigurierten Ollama-Provider ohne Controller-Änderung", async () => {
        process.env.LLM_PROVIDER = "ollama";
        process.env.OLLAMA_BASE_URL = "http://localhost:11434";
        process.env.OLLAMA_MODEL = "synthetic-test-model";
        const generated = {
            summary: "Erfundenes Beispiel",
            development: "",
            currentGoals: [],
            openPoints: [],
        };
        const fetchMock = jest.spyOn(globalThis, "fetch").mockResolvedValue({
            ok: true,
            json: async () => ({ done: true, response: JSON.stringify(generated) }),
        });

        const agent = request.agent(testApp());
        await agent.post("/test-login/7").expect(204);
        const response = await agent.post("/api/users/klientenakten/3/summary");

        expect(response.status).toBe(200);
        expect(response.body.summary).toEqual(generated);
        expect(response.body.metadata).toEqual({
            provider: "ollama",
            model: "synthetic-test-model",
            promptVersion: "summary-v2",
            sourceCount: 2,
            latencyMs: expect.any(Number),
        });
        expect(fetchMock).toHaveBeenCalledTimes(1);
    });
});
