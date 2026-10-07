const { PROMPT_VERSION, buildPrompt } = require("../promptBuilder");
const outputSchema = require("../outputSchema");
const ProviderError = require("./ProviderError");

const ENDPOINT = "https://api.mistral.ai/v1/chat/completions";

function createMistralProvider({ apiKey, model, timeoutMs = 120000, fetchImpl = globalThis.fetch }) {
    if (
        typeof apiKey !== "string" || !apiKey.trim() ||
        typeof model !== "string" || !model.trim() ||
        !Number.isSafeInteger(timeoutMs) || timeoutMs < 1 || timeoutMs > 600000 ||
        typeof fetchImpl !== "function"
    ) {
        throw new ProviderError("configuration");
    }

    return {
        name: "mistral",
        model,
        promptVersion: PROMPT_VERSION,

        async summarize(documentation, _options) {
            const { system, prompt } = buildPrompt(documentation);
            const controller = new AbortController();
            const timeout = setTimeout(() => controller.abort(), timeoutMs);

            try {
                const response = await fetchImpl(ENDPOINT, {
                    method: "POST",
                    headers: {
                        "Authorization": `Bearer ${apiKey}`,
                        "Content-Type": "application/json",
                    },
                    body: JSON.stringify({
                        model,
                        messages: [
                            { role: "system", content: system },
                            { role: "user", content: prompt },
                        ],
                        response_format: {
                            type: "json_schema",
                            json_schema: {
                                name: "conversation_summary",
                                schema: outputSchema,
                                strict: true,
                            },
                        },
                        temperature: 0,
                        stream: false,
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

                const choice = payload?.choices?.[0];
                if (choice?.finish_reason !== "stop" || typeof choice.message?.content !== "string") {
                    throw new ProviderError("invalid");
                }

                try {
                    return JSON.parse(choice.message.content);
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

module.exports = createMistralProvider;
