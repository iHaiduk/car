###*
Created by Ihor on 27.09.2014.
###

class _Car
  # Вернет инфу по вин коду
  getInfoVin: (code, myCallback) ->
    async.waterfall [
      (callback) ->
        AutoVin.findOneByCode code, (err, res) ->
          if not res? or not res.idYear?
            callback()
          else
            myCallback
              year: res.idYear
              make: res.idMake
              model: res.idModel

          return

      (callback) ->
        vin = require("vin") # http://www.decodethis.com/
        vin.lookup code, (vehicle) ->
          if vehicle.model?
            myCallback
              year: vehicle.year
              make: vehicle.make
              model: vehicle.model

          else
            callback()
          return

      (callback) ->
        EdmundsClient = require("node-edmunds-api") # http://developer.edmunds.com/
        client = new EdmundsClient(apiKey: "zsx3jzwjkk9ke7zq4ze9mjp3") # zsx3jzwjkk9ke7zq4ze9mjp3
        client.decodeVin
          vin: code
        , (err, res) ->
          if res? and res.status? and res.status isnt "NOT_FOUND"
            myCallback
              year: if res.years? then res.years[0].year else null
              make: res.make.name
              model: res.model.name

          else
            callback()
          return

    ], ->
      myCallback
        year: null
        make: null
        model: null
      return

  # Вернет все марки
  getMakes: (param = {}, myCallback) ->
    AutoMake.find().sort("name").exec (err, result) ->
      myCallback err, result if myCallback and typeof (myCallback) is "function"
      return

  # Вернет все модели
  getModels: (param = {}, myCallback) ->
    _this = this
    condition = {}
    async.waterfall [
      (callback) ->
        if param.params.make?
          callback null, param.params.make
        else
          callback null, null
      (make, callback) ->
        console.log(_this.isInteger parseInt(param.params.year))
        if param.params.year?
          AutoYear.findOneByYear(param.params.year).exec (err, year) ->
            callback null, make, year
            return
        else
          callback null, make, null
    ], (err, make, year) ->
      condition["id_make"] = make  if make?
      condition["idYear"] = year.id  if year?
      AutoModel.find(condition).populate('idYear').exec (err, resul) ->
        if not year?
          for model, key in resul
            resul[key].name += " ("+model.idYear.year+")"
        myCallback err, resul if myCallback and typeof (myCallback) is "function"
        return
      return

    return

  # Вернет все модификации и параметры модели
  getInfoModels: (param = {}, myCallback) ->
    _req = param
    id = param.params.id
    year = param.params.year
    type = param.params.type
    if type is "id"
      async.waterfall [(callback) ->
        if param.params.year?
          AutoYear.findOneByYear(param.params.year).exec (err, year) ->
            callback null, year
            return

        else
          callback null, null
        return
      ], (err, year) ->
        unless year?
          myCallback null, null if myCallback and typeof (myCallback) is "function"
        else
          AutoParam.find(
            model_id: id
            model_year: year.id
          ).populate("model_make_id").exec (err, resul) ->
            _req.setLocale 'ua'
            ret = for index, trim of resul

              id: trim.id
              model_trim: trim.model_trim
              model_transmission_type: trim.model_transmission_type
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

            myCallback null, ret if myCallback and typeof (myCallback) is "function"
            return

        return

    return

  # Вернет айди вин кода, а если таковой отсутсвует то создаст новую запись
  getIdVin: (code, callback) ->
    AutoVin.findOne({code: code}).exec (err, result) ->
      if not result?
        AutoVin.create({code: code}).exec (err, result) ->
          callback result if callback and typeof (callback) is "function"
      else
        callback result if callback and typeof (callback) is "function"

  # Проверка на число
  isInteger: (nVal) ->
    typeof nVal is "number" and isFinite(nVal) and nVal > -9007199254740992 and nVal < 9007199254740992 and Math.floor(nVal) is nVal
module.exports = new _Car