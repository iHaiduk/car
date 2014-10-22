###*
SettingsController

@description :: Server-side logic for managing settings
@help        :: See http://links.sailsjs.org/docs/controllers
###

#var code = "1N4AL3AP4DC295509";

unique = (arr) ->
  obj = {}
  objs = []
  k = 0
  i = 0

  while i < arr.length
    str = arr[i].name
    unless obj[str]?
      objs[k] = arr[i]
      k++
    obj[str] = true # запомнить строку в виде свойства объекта
    i++
  objs # или собрать ключи перебором для IE<9
module.exports =
  init: (req, res)->
    io.on "connection", (socket) ->
    socket.emit "news",
      hello: "world"

    socket.on "my other event", (data) ->
      console.log data
      return

    return

  index: (req, res) ->
    res.locals.styles = [
      "vendor/slider/css/slider.css"
      "vendor/chosen/chosen.min.css"
      "vendor/datetimepicker/css/bootstrap-datetimepicker.min.css"
      "vendor/codemirror/lib/codemirror.css"
      "vendor/tagsinput/bootstrap-tagsinput.css"
      "vendor/selectize/selectize.bootstrap3.css"
      "/cdnjs.cloudflare.com/ajax/libs/jquery.bootstrapvalidator/0.5.2/css/bootstrapValidator.min.css"
      "styles/style.css"
    ]
    res.locals.scripts = [
      "vendor/formwizard/js/bwizard.min.js"
      "vendor/codemirror/lib/codemirror.js"
      "vendor/codemirror/addon/mode/overlay.js"
      "vendor/codemirror/mode/markdown/markdown.js"
      "vendor/codemirror/mode/xml/xml.js"
      "vendor/codemirror/mode/gfm/gfm.js"
      "vendor/marked/marked.js"
      "vendor/parsley/parsley.min.js"
      "vendor/moment/min/moment-with-langs.min.js"
      "vendor/datetimepicker/js/bootstrap-datetimepicker.min.js"
      "vendor/tagsinput/bootstrap-tagsinput.min.js"
      "vendor/inputmask/jquery.inputmask.bundle.min.js"
      "vendor/validation/jquery.validate.js"
      "vendor/selectize/selectize.js"
      "/cdnjs.cloudflare.com/ajax/libs/jquery.bootstrapvalidator/0.5.2/js/bootstrapValidator.min.js"
      "controlScript/settingsIndex.js"
    ]
    kpp = {
      'Manual': req.__('Manual')
      'Automatic': req.__('Automatic')
      '4-speed manual': req.__('4-speed manual')
      '6-speed manual': req.__('6-speed manual')
      '6-speed automatic': req.__('6-speed automatic')
      '5-speed manual': req.__('5-speed manual')
      'Single Speed': req.__('Single Speed')
      'CVT': req.__('CVT')
      '7-speed automatic': req.__('7-speed automatic')
      '5-speed shiftable automatic': req.__('5-speed shiftable automatic')
      '6-speed automated manual': req.__('6-speed automated manual')
      '5-speed automated manual': req.__('5-speed automated manual')
      '8-speed shiftable automatic': req.__('8-speed shiftable automatic')
      '5-speed automatic': req.__('5-speed automatic')
      '4-speed automatic': req.__('4-speed automatic')
      '6-speed shiftable automatic': req.__('6-speed shiftable automatic')
      '7-speed shiftable automatic': req.__('7-speed shiftable automatic')
      '7-speed automated manual': req.__('7-speed automated manual')
      '8-speed automated manual': req.__('8-speed automated manual')
      '8-speed automatic': req.__('8-speed automatic')
      '4-speed shiftable automatic': req.__('4-speed shiftable automatic')
      '7-speed manual': req.__('7-speed manual')
      'Automated Manual': req.__('Automated Manual')
      'Direct Drive': req.__('Direct Drive')
    }

    req.setLocale 'ua'
    res.view "settings/index"
    return

  getVin: (req, res) ->
    code = req.query.vin
    _Car.getInfoVin code, (result) ->
      res.json result
    return

  getMakes: (req, res) ->
    _Car.getMakes {}, (err, result) ->
      res.json result
    return

  getModels: (req, res) ->
    _Car.getModels req, (err, result) ->
      res.json unique(result)
    return

  getInfoModels: (req, res) ->
    _Car.getInfoModels req, (err, result) ->
      res.json result
    return

  getParam: (req, res) ->
    transmission = staticVariable.model_transmission_type
    console.log(transmission)