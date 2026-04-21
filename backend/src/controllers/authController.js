const authService = require("../services/authService");

async function register(req, res, next) {
    try {
        const result = await authService.register(req.body);
        res.status(201).json(result);
    } catch (err) {
        next(err);
    }
}

async function login(req, res, next) {
    try {
        const result = await authService.login(req.body, req.session);
        res.status(200).json(result);
    } catch (err) {
        next(err);
    }
}

async function logout(req, res, next) {
    try {
        await authService.logout(req.session);
        res.status(200).json({ message: "Logout erfolgreich" });
    } catch (err) {
        next(err);
    }
}

async function whoami(req, res, next) {
    try {
        const result = await authService.whoami(req.session);
        res.status(200).json(result);
    } catch (err) {
        next(err);
    }
}

module.exports = {
    register,
    login,
    logout,
    whoami,
};