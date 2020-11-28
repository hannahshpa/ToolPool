module.exports = function(req, res, next) {
    res.error = function(statusCode, codeString, reason) {
        res.status(statusCode).send({ code: codeString, reason: reason });
    };
    next();
};
