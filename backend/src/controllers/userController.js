const userService = require("../services/userService");

async function updateUser(req, res, next) {
    try {
        const result = await userService.updateCurrentUser(req.body, req.session);
        res.status(200).json(result);
    } catch (err) {
        next(err);
    }
}

async function deleteUser(req, res, next) {
    try {
        await userService.deleteCurrentUser(req.session);
        res.status(204).send();
    } catch (err) {
        next(err);
    }
}

module.exports = {
    updateUser,
    deleteUser,
};