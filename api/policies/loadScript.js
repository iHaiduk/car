module.exports = function loadScript(req, res, next) {

    res.locals.scripts = [
        "/js/app.js"
    ];
    res.locals.styles = [];

    next();
};