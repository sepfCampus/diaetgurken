function requireLogin(req, res, next) {
    if (!req.session || !req.session.userId) {
        return res.status(401).json({ error: "Nicht eingeloggt" });
    }

    next();
}

module.exports = requireLogin;