module.exports = (req, res, next) ->

    # User is allowed, proceed to the next policy,
    # or if this is the last policy, the controller
    req.session.user = 1  unless req.session.user?
    return next()  if req.session.authenticated

        # User is not allowed
    # (default res.forbidden() behavior can be overridden in `config/403.js`)
    res.forbidden "You are not permitted to perform this action."