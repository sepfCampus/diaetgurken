const einstellungenService = require('../services/einstellungenService');

async function getEinstellungen(req, res, next) {
    try {
        const result = await einstellungenService.getforCurrentUser(req.session);
        res.status(200).json(result);
    } catch (err) {
        next(err);
    }
}

async function updateEinstellungen(req, res, next) {
    try {
        const result = await einstellungenService.updateEinstellungen(req.body, req.session);
        res.status(200).json(result);
    } catch (err) {
        next(err);
    }
}

module.exports = {
    getEinstellungen,
    updateEinstellungen,
};