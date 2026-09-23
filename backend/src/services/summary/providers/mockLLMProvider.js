const mockLLMProvider = {
    name: "mock",

    async summarize(documentation, _options) {
        return {
            summary: `Testausgabe: ${documentation.length} dokumentierte Gespräche vorhanden.`,
            development: "",
            currentGoals: [],
            openPoints: [],
        };
    },
};

module.exports = mockLLMProvider;
