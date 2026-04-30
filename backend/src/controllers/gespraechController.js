const gespraechService = require("../services/gespraechService");

async function getAll(req, res, next) {
    try {
        const result = await gespraechService.getAllForKlientenAkte(
            req.params.klientenAkteId,
            req.session
        );
        res.status(200).json(result);
    } catch (err) {
        next(err);
    }
}

async function create(req, res, next) {
    try {
        const result = await gespraechService.createForCurrentUser({
            ...req.body,
            klientenAkteId: req.params.klientenAkteId
        }, req.session);
        res.status(201).json(result);
    } catch (err) {
        next(err);
    }
}

async function update(req, res, next) {
    try {
        const result = await gespraechService.updateForCurrentUser({
            ...req.body,
            klientenAkteId: req.params.klientenAkteId,
            id: req.params.id
        }, req.session);
        res.status(200).json(result);
    } catch (err) {
        next(err);
    }
}

async function remove(req, res, next) {
    try {
        await gespraechService.deleteForCurrentUser(req.params.id, req.session);
        res.status(204).send();
    } catch (err) {
        next(err);
    }
}

module.exports = {
    getAll,
    create,
    update,
    remove,
};