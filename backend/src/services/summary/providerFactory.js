const ApiError = require("../../utils/ApiError");
const mockLLMProvider = require("./providers/mockLLMProvider");
const createOllamaProvider = require("./providers/ollamaProvider");

function createProvider() {
    const name = process.env.LLM_PROVIDER || "mock";

    if (name === "mock") {
        return mockLLMProvider;
    }

    if (name === "ollama") {
        try {
            return createOllamaProvider({
                baseUrl: process.env.OLLAMA_BASE_URL,
                model: process.env.OLLAMA_MODEL,
                timeoutMs: process.env.OLLAMA_TIMEOUT_MS
                    ? Number(process.env.OLLAMA_TIMEOUT_MS)
                    : 120000,
            });
        } catch (err) {
            throw new ApiError(503, "Zusammenfassungsdienst nicht verfügbar");
        }
    }

    throw new ApiError(503, "Zusammenfassungsdienst nicht verfügbar");
}

module.exports = createProvider;
