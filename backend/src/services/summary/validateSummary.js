const ApiError = require("../../utils/ApiError");

function validateSummary(value) {
    if (
        !value ||
        typeof value !== "object" ||
        Array.isArray(value) ||
        typeof value.summary !== "string" ||
        typeof value.development !== "string" ||
        !Array.isArray(value.currentGoals) ||
        !value.currentGoals.every(item => typeof item === "string") ||
        !Array.isArray(value.openPoints) ||
        !value.openPoints.every(item => typeof item === "string")
    ) {
        throw new ApiError(502, "Ungültige Antwort des Zusammenfassungsdienstes");
    }

    return {
        summary: value.summary,
        development: value.development,
        currentGoals: value.currentGoals,
        openPoints: value.openPoints,
    };
}

module.exports = validateSummary;
