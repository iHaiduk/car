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
    script_array = [
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
    ]
    stringifyObject = require('stringify-object')
    toMarkdown = require('to-markdown').toMarkdown
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

    uic = UserCar.findOne({user_id: req.session.user}).exec (err, resul) ->
      if resul?
        auto_save = if resul.save? then resul.save else 0
        delete resul.id
        delete resul.user_id
        delete resul.inspect
        console.log resul.text_differences
        resul.сhoice_differences = JSON.parse(resul.сhoice_differences)
        resul.text_differences = if resul.text_differences? then toMarkdown(resul.text_differences) else null
        AutoVin.findOne(resul.vinCode).exec (err, code) ->
          resul.vinCode = code.code if resul? and code?
          resul = stringifyObject resul, {indent: '', singleQuotes: false } if resul? and auto_save is 0

          script_array.push("controlScript/newEditCar.js") if auto_save is 0
          script_array.push("controlScript/viewCar.js") if auto_save is 1
          res.locals.scripts = script_array
          res.view "settings/index", {_save: auto_save, kpp: model_transmission_type, model_body: model_body, region: region, country: country, model_drive: model_drive, model_engine_type: model_engine_type, model_engine_position: model_engine_position, model_engine_fuel: model_engine_fuel, usr_car_param: resul}
      else
        script_array.push("controlScript/newEditCar.js")
        res.locals.scripts = script_array
        res.view "settings/index", {_save: 0, kpp: model_transmission_type, model_body: model_body, region: region, country: country, model_drive: model_drive, model_engine_type: model_engine_type, model_engine_position: model_engine_position, model_engine_fuel: model_engine_fuel, usr_car_param: "{}"}
      return
    return

  getVin: (req, res) ->
    code = req.query.vin
    _Car.getIdVin code, (vin)->
      _User.setUserCar req.session, {vinCode: vin.id}
    _Car.getInfoVin code, (result) ->
      if result.make?
        async.waterfall [
          (callback) ->
            AutoMake.findOne({name:result.make}).exec (err, make) ->
              callback null, make.id
            return
          (make, callback) ->
            if make?
              AutoYear.findOne({year:result.year}).exec (err, year) ->
                callback null, make, year.id
            else
              callback null, null, null
          (make, year, callback) ->
            if make?
              AutoModel.findOne({name:result.model, id_make:make, idYear:year}).exec (err, model) ->
                callback null, make, model.id, year
              return
            else
              callback null, null, null, null
        ], (err, make_id, model_id, year)->
          AutoModel.find({id_make: make_id, idYear:year}).exec (err, models) ->
            res.json
              year: result.year
              make: result.make
              model: result.model
              make_id: make_id
              model_id: model_id
              models: models
          return
      else
        res.json result
    return

  getMakes: (req, res) ->
    _Car.getMakes {}, (err, result) ->
      res.json result
    return

  getModels: (req, res) ->
    #_User.setUserCar req.session, {make_id: req.params.make}
    _Car.getModels req, (err, result) ->
      res.json unique(result)
    return

  getInfoModels: (req, res) ->
    #_User.setUserCar req.session, {model_id: req.params.id, model_year: req.params.year}
    _Car.getInfoModels req, (err, result) ->
      res.json result
    return

  setParam: (req, res) ->
    _User.setUserCar req.session, req.body, ()->
      res.send("true")