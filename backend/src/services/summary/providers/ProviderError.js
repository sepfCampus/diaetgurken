class ProviderError extends Error {
    constructor(kind) {
        super(kind);
        this.kind = kind;
    }
}

module.exports = ProviderError;
