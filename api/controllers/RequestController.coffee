###*
PromoController

@description :: Server-side logic for managing promoes
@help        :: See http://links.sailsjs.org/docs/controllers
###

_Request=
  getRequest: (req, res)->
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
    user_car = UserCar.find({user_id: req.session.user}).exec (err, resul) ->
      res.locals.scripts = script_array
      res.locals.modal = "modal/addRequest"
      console.log user_car
      res.view("request/index", {user_car: resul})


  newRequest: (req, res)->
    req.body.uid_car = req.body.user_car
    req.body.uid_user = req.session.user
    req.body.part_number = (if req.body.part_number is "" or not req.body.part_number? then null else parseInt(req.body.part_number))
    req.body.group_of_spare_parts = parseInt(req.body.group_of_spare_parts)
    req.body.type_of_spare_parts = parseInt(req.body.type_of_spare_parts)
    req.body.condition_parts = parseInt(req.body.condition_parts)
    req.body.link_item = null if req.body.link_item is ""
    req.body.files = null if req.body.files is ""
    Request.create req.body, (err,result) ->
      res.json
        error: err
        result: result

module.exports = _Request
