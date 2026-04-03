const klarnameRepository = require("../repositories/mock/klarnameRepository");
const klientenAkteRepository = require("../repositories/mock/klientenAkteRepository");
const userRepository = require("../repositories/mock/userRepository");
const { comparePassword } = require("../utils/passwordUtil");
const ApiError = require("../utils/ApiError");

async function getKlarname({ klientenAkteId, password }, session) {
    if (!session?.userId) {
        throw new ApiError(401, "Nicht eingeloggt");
    }

    if (!klientenAkteId || !password) {
        throw new ApiError(400, "KlientenakteId und Passwort sind erforderlich");
    }

    const akte = klientenAkteRepository.findById(Number(klientenAkteId));
    if (!akte) {
        throw new ApiError(404, "Klientenakte nicht gefunden");
    }

    if (akte.userId !== session.userId) {
        throw new ApiError(403, "Kein Zugriff auf diese Klientenakte");
    }

    const user = userRepository.findById(session.userId);
    if (!user) {
        throw new ApiError(404, "Benutzer nicht gefunden");
    }

    const passwordMatches = await comparePassword(password, user.passwordHash);
    if (!passwordMatches) {
        throw new ApiError(401, "Passwort ist nicht korrekt");
    }

    const klarname = klarnameRepository.findByKlientenAkteId(Number(klientenAkteId));

    if (!klarname) {
        throw new ApiError(404, "Kein Klarname für diese Klientenakte gefunden");
    }

    return klarname;
}

async function updateKlarname({ klientenAkteId, password, name }, session) {
    if (!session?.userId) {
        throw new ApiError(401, "Nicht eingeloggt");
    }

    if (!klientenAkteId || !password || !name) {
        throw new ApiError(400, "KlientenakteId, Passwort und Name sind erforderlich");
    }

    const akte = klientenAkteRepository.findById(Number(klientenAkteId));
    if (!akte) {
        throw new ApiError(404, "Klientenakte nicht gefunden");
    }

    if (akte.userId !== session.userId) {
        throw new ApiError(403, "Kein Zugriff auf diese Klientenakte");
    }

    const user = userRepository.findById(session.userId);
    if (!user) {
        throw new ApiError(404, "Benutzer nicht gefunden");
    }

    const passwordMatches = await comparePassword(password, user.passwordHash);
    if (!passwordMatches) {
        throw new ApiError(401, "Passwort ist nicht korrekt");
    }

    return klarnameRepository.upsert({
        klientenAkteId: Number(klientenAkteId),
        name,
    });
}

module.exports = {
    getKlarname,
    updateKlarname,
};