function buildContext(req) {
    return {
        session: req.session,
    };
}

module.exports = { buildContext };