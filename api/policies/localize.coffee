module.exports = (req, res, next) ->
  req.setLocale req.session.languagePreference
  next()
  return