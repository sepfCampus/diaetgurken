const summaryService = require("../services/summaryService");

async function create(req, res, next) {
    try {
        const result = await summaryService.summarizeForCurrentUser(
            req.params.klientenAkteId,
            req.session
        );
        res.status(200).json(result);
    } catch (err) {
        next(err);
    }
}

module.exports = { create };
