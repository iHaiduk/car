module.exports = (req, res, next) ->
  next()
#  if req.session.user?
#    next()
#  else
#    res.redirect "/"