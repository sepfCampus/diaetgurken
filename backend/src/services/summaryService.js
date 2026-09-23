const klientenAkteRepository = require("../repositories/prisma/klientenAkteRepositoryPrisma");
const gespraechRepository = require("../repositories/prisma/gespraechRepositoryPrisma");
const ApiError = require("../utils/ApiError");
const createProvider = require("./summary/providerFactory");
const validateSummary = require("./summary/validateSummary");
const ProviderError = require("./summary/providers/ProviderError");

function createSummaryService({
    aktenRepository = klientenAkteRepository,
    gespraecheRepository = gespraechRepository,
    provider,
} = {}) {
    async function summarizeForCurrentUser(klientenAkteId, session) {
        if (!session?.userId) {
            throw new ApiError(401, "Nicht eingeloggt");
        }

        const idText = String(klientenAkteId);
        const id = Number(idText);
        if (!/^[1-9]\d*$/.test(idText) || !Number.isSafeInteger(id)) {
            throw new ApiError(400, "Ungültige KlientenAkteId");
        }

        const akte = await aktenRepository.findOwnerById(id);
        if (!akte) {
            throw new ApiError(404, "Klientenakte nicht gefunden");
        }
        if (akte.userId !== session.userId) {
            throw new ApiError(403, "Kein Zugriff auf diese Klientenakte");
        }

        const gespraeche = await gespraecheRepository.findForSummaryByAkteId(id);
        if (gespraeche.length === 0) {
            throw new ApiError(422, "Keine Gespräche vorhanden");
        }

        const documentation = gespraeche.map(gespraech => ({
            id: gespraech.id,
            datum: gespraech.datum.toISOString().slice(0, 10),
            assessment: gespraech.assessment,
            diagnosen: gespraech.diagnosen,
            ziele: gespraech.ziele,
            outcome: gespraech.outcome,
            notizen: gespraech.notizen,
        }));

        const selectedProvider = provider || createProvider();
        let generated;
        const startedAt = performance.now();
        try {
            generated = await selectedProvider.summarize(documentation, {});
        } catch (err) {
            if (err instanceof ProviderError && err.kind === "invalid") {
                throw new ApiError(502, "Ungültige Antwort des Zusammenfassungsdienstes");
            }
            throw new ApiError(503, "Zusammenfassungsdienst nicht verfügbar");
        }

        const metadata = {
            provider: selectedProvider.name,
            sourceCount: documentation.length,
            latencyMs: Math.round(performance.now() - startedAt),
        };
        if (selectedProvider.model) metadata.model = selectedProvider.model;
        if (selectedProvider.promptVersion) metadata.promptVersion = selectedProvider.promptVersion;

        return {
            summary: validateSummary(generated),
            metadata,
            reviewRequired: true,
        };
    }

    return { summarizeForCurrentUser };
}

module.exports = {
    createSummaryService,
    ...createSummaryService(),
};
