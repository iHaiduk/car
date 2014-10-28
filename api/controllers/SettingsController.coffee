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
      "vendor/bootstrapvalidator/js/bootstrapValidator.js"
      "vendor/serializeJSON/jquery.serializejson.js"
      "vendor/mask/jquery.numberMask.js"
      "controlScript/settingsIndex.js"
    ]
    stringifyObject = require('stringify-object')
    req.session.languagePreference = 'ua'
    req.setLocale req.session.languagePreference

    model_transmission_type = _objOption.keyed(_staticVariable.model_transmission_type(req))
    model_transmission_type = stringifyObject model_transmission_type, {indent: '', singleQuotes: false }
    model_body = _objOption.keyed(_staticVariable.model_body(req))
    model_body = stringifyObject model_body, {indent: '', singleQuotes: false }
    region = _objOption.keyed(_staticVariable.region(req))
    region = stringifyObject region, {indent: '', singleQuotes: false }
    country = _objOption.keyed(_staticVariable.country(req))
    country = stringifyObject country, {indent: '', singleQuotes: false }
    model_drive = _objOption.keyed(_staticVariable.model_drive(req))
    model_drive = stringifyObject model_drive, {indent: '', singleQuotes: false }
    model_engine_type = _objOption.keyed(_staticVariable.model_engine_type(req))
    model_engine_type = stringifyObject model_engine_type, {indent: '', singleQuotes: false }
    model_engine_position = _objOption.keyed(_staticVariable.model_engine_position(req))
    model_engine_position = stringifyObject model_engine_position, {indent: '', singleQuotes: false }
    model_engine_fuel = _objOption.keyed(_staticVariable.model_engine_fuel(req))
    model_engine_fuel = stringifyObject model_engine_fuel, {indent: '', singleQuotes: false }


    res.view "settings/index", {kpp: model_transmission_type, model_body: model_body, region: region, country: country, model_drive: model_drive, model_engine_type: model_engine_type, model_engine_position: model_engine_position, model_engine_fuel: model_engine_fuel}
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
    _User.setUserCar {session: req.session, make: req.params.make}
    _Car.getModels req, (err, result) ->
      res.json unique(result)
    return

  getInfoModels: (req, res) ->
    _User.setUserCar {session: req.session, model: req.params.id, year: req.params.year}
    _Car.getInfoModels req, (err, result) ->
      res.json result
    return

  getParam: (req, res) ->
    transmission = staticVariable.model_transmission_type
    console.log(transmission)