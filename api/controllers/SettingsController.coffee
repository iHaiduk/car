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
    Car.getInfoVin code, (result) ->
      res.json result
      return

    return

  getMakes: (req, res) ->
    AutoMake.find().sort("name").exec (err, result) ->
      res.json result
    return

  getModels: (req, res) ->
    condition = {}
    async.waterfall [
      (callback) ->
        if req.params.make?
          callback null, req.params.make
        else
          callback null, null
      (make, callback) ->
        if req.params.year?
          AutoYear.findOneByYear(req.params.year).exec (err, year) ->
            callback null, make, year
            return

        else
          callback null, make, null
    ], (err, make, year) ->
      condition["id_make"] = make  if make?
      condition["idYear"] = year.id  if year?
      AutoModel.find(condition).sort("name").exec (err, resul) ->
        res.json unique(resul)
        return

      return

    return

  getInfoModels: (req, res) ->
    _req = req
    id = req.params.id
    year = req.params.year
    type = req.params.type
    if type is "id"
      async.waterfall [(callback) ->
        if req.params.year?
          AutoYear.findOneByYear(req.params.year).exec (err, year) ->
            callback null, year
            return

        else
          callback null, null
        return
      ], (err, year) ->
        unless year?
          res.json {}
        else
          AutoParam.find(
            model_id: id
            model_year: year.id
          ).populate("model_make_id").exec (err, resul) ->
            _req.setLocale 'ua'
            ret = for index, trim of resul

              id: trim.id
              model_trim: trim.model_trim
              model_transmission_type: _req.__(trim.model_transmission_type) if trim.model_transmission_type?
              model_body: trim.model_body #req.__(trim.model_body)
              region: trim.region #req.__(trim.region)
              country: trim.model_make_id.country #req.__("ua")
              model_drive: trim.model_drive #req.__(trim.model_drive)
              model_engine_type: trim.model_engine_type #req.__(trim.model_engine_type)
              model_engine_position: trim.model_engine_position #req.__(trim.model_engine_position)
              model_engine_cyl: trim.model_engine_cyl
              model_engine_cc: trim.model_engine_cc
              model_engine_ci: trim.model_engine_ci
              model_engine_valves_per_cyl: trim.model_engine_valves_per_cyl
              model_engine_torque_rpm: trim.model_engine_torque_rpm
              model_engine_fuel: trim.model_engine_fuel
              model_lkm_hwy: trim.model_lkm_hwy
              model_lkm_city: trim.model_lkm_city
              model_fuel_cap_l: trim.model_fuel_cap_l
              model_length_mm: trim.model_length_mm
              model_width_mm: trim.model_width_mm
              model_height_mm: trim.model_height_mm
              model_weight_kg: trim.model_weight_kg

            res.json ret
            return

        return

    return

  getParam: (req, res) ->
    transmission = staticVariable.model_transmission_type
    console.log(transmission)