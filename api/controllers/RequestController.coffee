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
      "controlScript/requestMain.js"
    ]
    res.locals.scripts = script_array
    res.locals.modal = "modal/addRequest"
    res.view("request/index")


module.exports = _Request
