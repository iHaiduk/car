###*
PromoController

@description :: Server-side logic for managing promoes
@help        :: See http://links.sailsjs.org/docs/controllers
###

_Request=
  getRequest: (req, res)->
    res.view("request/index")


module.exports = _Request
