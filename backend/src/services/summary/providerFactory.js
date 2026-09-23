const ApiError = require("../../utils/ApiError");
const mockLLMProvider = require("./providers/mockLLMProvider");

function createProvider() {
    const name = process.env.LLM_PROVIDER || "mock";

    if (name === "mock") {
        return mockLLMProvider;
    }

    throw new ApiError(503, "Zusammenfassungsdienst nicht verfügbar");
}

module.exports = createProvider;
