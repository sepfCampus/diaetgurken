const klientenAkteService = require("../services/klientenAkteService");

async function getAll(req, res, next) {
    try {
        const result = await klientenAkteService.getAllForCurrentUser(req.session);
        res.status(200).json(result);
    } catch (err) {
        next(err);
    }
}

async function create(req, res, next) {
    try {
        const result = await klientenAkteService.createForCurrentUser(req.session, req.body.name);
        res.status(201).json(result);
    } catch (err) {
        next(err);
    }
}

async function remove(req, res, next) {
    try {
        await klientenAkteService.deleteForCurrentUser(req.params.id, req.session);
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