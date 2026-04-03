const klientenAkteService = require("../services/klientenAkteService");

function getAll(req, res, next) {
    try {
        const result = klientenAkteService.getAllForCurrentUser(req.session);
        res.status(200).json(result);
    } catch (err) {
        next(err);
    }
}

function create(req, res, next) {
    try {
        const result = klientenAkteService.createForCurrentUser(req.session);
        res.status(201).json(result);
    } catch (err) {
        next(err);
    }
}

function remove(req, res, next) {
    try {
        klientenAkteService.deleteForCurrentUser(req.params.id, req.session);
        res.status(204).send();
    } catch (err) {
        next(err);
    }
}

module.exports = {
    getAll,
    create,
    remove,
};