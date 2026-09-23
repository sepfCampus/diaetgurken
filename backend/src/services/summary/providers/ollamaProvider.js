const { PROMPT_VERSION, buildPrompt } = require("../promptBuilder");
const outputSchema = require("../outputSchema");
const ProviderError = require("./ProviderError");

function createOllamaProvider({ baseUrl, model, timeoutMs = 120000, fetchImpl = globalThis.fetch }) {
    let endpoint;
    try {
        const url = new URL(baseUrl);
        if (
            !["http:", "https:"].includes(url.protocol) ||
            url.username || url.password || url.search || url.hash
        ) {
            throw new Error("Ungültige URL");
        }
        endpoint = new URL("/api/generate", url);
    } catch (err) {
        throw new ProviderError("configuration");
    }

    if (!model || !Number.isSafeInteger(timeoutMs) || timeoutMs < 1 || timeoutMs > 600000 || typeof fetchImpl !== "function") {
        throw new ProviderError("configuration");
    }

    return {
        name: "ollama",
        model,
        promptVersion: PROMPT_VERSION,

        async summarize(documentation, _options) {
            const { system, prompt } = buildPrompt(documentation);
            const controller = new AbortController();
            const timeout = setTimeout(() => controller.abort(), timeoutMs);

            try {
                const response = await fetchImpl(endpoint, {
                    method: "POST",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify({
                        model,
                        system,
                        prompt,
                        format: outputSchema,
                        stream: false,
                        options: { temperature: 0 },
                    }),
                    signal: controller.signal,
                });

                if (!response.ok) {
                    throw new ProviderError("unavailable");
                }

                let payload;
                try {
                    payload = await response.json();
                } catch (err) {
                    throw new ProviderError("invalid");
                }

                if (payload?.done !== true || typeof payload.response !== "string") {
                    throw new ProviderError("invalid");
                }

                try {
                    return JSON.parse(payload.response);
                } catch (err) {
                    throw new ProviderError("invalid");
                }
            } catch (err) {
                if (err instanceof ProviderError) {
                    throw err;
                }
                throw new ProviderError("unavailable");
            } finally {
                clearTimeout(timeout);
            }
        },
    };
}

module.exports = createOllamaProvider;
