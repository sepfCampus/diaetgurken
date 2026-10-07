const ApiError = require("../../utils/ApiError");
const mockLLMProvider = require("./providers/mockLLMProvider");
const createOllamaProvider = require("./providers/ollamaProvider");
const createMistralProvider = require("./providers/mistralProvider");

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

    if (name === "mistral") {
        try {
            return createMistralProvider({
                apiKey: process.env.MISTRAL_API_KEY,
                model: process.env.MISTRAL_MODEL,
                timeoutMs: process.env.MISTRAL_TIMEOUT_MS
                    ? Number(process.env.MISTRAL_TIMEOUT_MS)
                    : 120000,
            });
        } catch (err) {
            throw new ApiError(503, "Zusammenfassungsdienst nicht verfügbar");
        }
    }

    throw new ApiError(503, "Zusammenfassungsdienst nicht verfügbar");
}

module.exports = createProvider;
