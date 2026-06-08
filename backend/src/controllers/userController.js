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
        req.session.destroy((err) => {
            if (err) {
                return next(err);
            }
            res.status(204).send();
        });
    } catch (err) {
        next(err);
    }
}

async function changePassword(req, res, next) {
    try {
        const { oldPassword, newPassword } = req.body;
        await userService.changePassword(oldPassword, newPassword, req.session);
        res.status(200).json({ message: "Passwort erfolgreich geändert" });
    } catch (err) {
        next(err);
    }
}

module.exports = {
    updateUser,
    deleteUser,
    changePassword,
};