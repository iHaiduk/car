###*
PromoController

@description :: Server-side logic for managing promoes
@help        :: See http://links.sailsjs.org/docs/controllers
###

_Request=
  getRequest: (req, res)->
    require "date-format-lite"

    res.locals.styles = [
      "vendor/selectize/selectize.bootstrap3.css"
      "styles/styleRequest.css"
    ]
    script_array = [
      "vendor/datatable/media/js/jquery.dataTables.min.js"
      "vendor/datatable/extensions/datatable-bootstrap/js/dataTables.bootstrap.js"
      "vendor/datatable/extensions/datatable-bootstrap/js/dataTables.bootstrapPagination.js"
      "vendor/datatable/extensions/ColVis/js/dataTables.colVis.min.js"
      "vendor/selectize/selectize.js"
      "vendor/mask/jquery.numberMask.js"
      "vendor/mask/jquery.mask.min.js"
      "vendor/ajax/upload.js"
      "controlScript/requestMain.js"
    ]
    async.series
      user_car: (callback) ->
        UserCar.find({user_id: req.session.user}).exec (err, resul) ->
          callback err, resul
        return

      request: (callback) ->
        Request.find({uid_user: req.session.user}).populate('uid_car').exec (err, resul) ->
          i = 0
          len = resul.length

          while i < len
            now = new Date(parseInt(resul[i].time) * 1000)
            resul[i].time = now.format("DD.MM.Y h:mm")
            i++
          callback err, resul
        return
    , (err, results) ->
      res.locals.scripts = script_array
      res.locals.modal = [
        "modal/addRequest"
        "modal/infoCars"
      ]
      res.view "request/index",
        user_cars: results.user_car
        requests: results.request


# results is now equal to: {one: 1, two: 2}


  newRequest: (req, res)->
    require "date-format-lite"
    _User.getUserCar req, (data)->
      res.json data
    return

module.exports = _Request
