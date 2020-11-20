var resError = require("./res.error.js");

module.exports = function(req, res, next) {
    resError(req, res, next);
};
