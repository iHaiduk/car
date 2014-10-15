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
    res.view "settings/index"
    return

  getVin: (req, res) ->
    code = req.query.vin | "1N4AL3AP4DC295509"
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
          ).exec (err, resul) ->
            res.json resul
            return

        return

    return