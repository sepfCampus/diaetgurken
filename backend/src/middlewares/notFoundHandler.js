function notFoundHandler(req, res, next) {
    res.status(404).json({ error: "Route nicht gefunden" });
}

module.exports = notFoundHandler;