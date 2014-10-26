module.exports = (req, res, next) ->
  req.session.languagePreference = (if req.session.languagePreference? then req.session.languagePreference else "en")
  req.setLocale req.session.languagePreference
  next()
  return