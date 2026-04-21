const klarnameService = require("../services/klarnameService");

async function getKlarname(req, res, next) {
    try {
        const result = await klarnameService.getKlarname({
            ...req.body,
            klientenAkteId: req.params.klientenAkteId
        }, req.session);
        res.status(200).json(result);
    } catch (err) {
        next(err);
    }
}

async function updateKlarname(req, res, next) {
    try {
        const result = await klarnameService.updateKlarname({
            ...req.body,
            klientenAkteId: req.params.klientenAkteId
        }, req.session);
        res.status(200).json(result);
    } catch (err) {
        next(err);
    }
}

module.exports = {
    getKlarname,
    updateKlarname,
};
