const grpc = require("@grpc/grpc-js");
const gespraechService = require("../../services/gespraechService");
const ApiError = require("../../utils/ApiError");

function safeParse(value) {
    if (!value) return null;
    try {
        return JSON.parse(value);
    } catch {
        throw new ApiError(400, "Ungültiges JSON im Request");
    }
}

function safeStringify(value) {
    if (value == null) return "";
    return JSON.stringify(value);
}

function mapToGrpc(gespraech) {
    return {
        id: gespraech.id,
        klientenAkteId: gespraech.klientenAkteId,
        datum: gespraech.datum ? new Date(gespraech.datum).toISOString() : "",
        formMetaData: safeStringify(gespraech.formMetaData),
        assessment: safeStringify(gespraech.assessment),
        diagnosen: safeStringify(gespraech.diagnosen),
        ziele: safeStringify(gespraech.ziele),
        outcome: safeStringify(gespraech.outcome),
        notizen: gespraech.notizen ?? "",
    };
}

function mapErrorToGrpc(error) {
    if (error instanceof ApiError) {
        switch (error.statusCode) {
            case 400:
                return { code: grpc.status.INVALID_ARGUMENT, message: error.message };
            case 401:
                return { code: grpc.status.UNAUTHENTICATED, message: error.message };
            case 403:
                return { code: grpc.status.PERMISSION_DENIED, message: error.message };
            case 404:
                return { code: grpc.status.NOT_FOUND, message: error.message };
            default:
                return { code: grpc.status.INTERNAL, message: error.message };
        }
    }

    return {
        code: grpc.status.INTERNAL,
        message: "Interner Serverfehler",
    };
}

async function createGespraech(call, callback) {
    try {
        const req = call.request;

        const session = {
            userId: Number(req.userId),
        };

        const created = await gespraechService.createForCurrentUser(
            {
                klientenAkteId: req.klientenAkteId,
                datum: req.datum,
                formMetaData: safeParse(req.formMetaData),
                assessment: safeParse(req.assessment),
                diagnosen: safeParse(req.diagnosen),
                ziele: safeParse(req.ziele),
                outcome: safeParse(req.outcome),
                notizen: req.notizen || null,
            },
            session
        );

        callback(null, mapToGrpc(created));
    } catch (error) {
        callback(mapErrorToGrpc(error));
    }
}

async function getGespraeche(call, callback) {
    try {
        const req = call.request;

        const session = {
            userId: Number(req.userId),
        };

        const list = await gespraechService.getAllForKlientenAkte(
            req.klientenAkteId,
            session
        );

        callback(null, {
            gespraeche: list.map(mapToGrpc),
        });
    } catch (error) {
        callback(mapErrorToGrpc(error));
    }
}

module.exports = {
    CreateGespraech: createGespraech,
    GetGespraeche: getGespraeche,
};