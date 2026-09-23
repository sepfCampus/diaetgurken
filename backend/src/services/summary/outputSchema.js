module.exports = {
    type: "object",
    properties: {
        summary: { type: "string" },
        development: { type: "string" },
        currentGoals: { type: "array", items: { type: "string" } },
        openPoints: { type: "array", items: { type: "string" } },
    },
    required: ["summary", "development", "currentGoals", "openPoints"],
    additionalProperties: false,
};
