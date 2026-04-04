const gespraechService = require("../services/gespraechService");

function getAll(req, res, next) {
    try {
        const result = gespraechService.getAllForKlientenAkte(
            req.params.klientenAkteId,
            req.session
        );
        res.status(200).json(result);
    } catch (err) {
        next(err);
    }
}

function create(req, res, next) {
    try {
        const result = gespraechService.createForCurrentUser(req.body, req.session);
        res.status(201).json(result);
    } catch (err) {
        next(err);
    }
}

function update(req, res, next) {
    try {
        const result = gespraechService.updateForCurrentUser(req.body, req.session);
        res.status(200).json(result);
    } catch (err) {
        next(err);
    }
}

function remove(req, res, next) {
    try {
        gespraechService.deleteForCurrentUser(req.params.id, req.session);
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