###*
Created by Ihor on 27.09.2014.
###

exports.getInfoVin = (code, myCallback) ->
  async.waterfall [
    (callback) ->
      AutoVin.findOneByCode code, (err, res) ->
        if not res? or not res.idYear?
          callback()
        else
          console.log res
          myCallback
            year: res.idYear
            make: res.idMake
            model: res.idModel

        return

    (callback) ->
      vin = require("vin") # http://www.decodethis.com/
      vin.lookup code, (vehicle) ->
        console.log "decodethis", vehicle
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
        console.log "developer", res
        if res? and res.status? and res.status isnt "NOT_FOUND"
          myCallback
            year: res.years[0].year
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



exports.getMakes = (param = {}, myCallback) ->
  AutoMake.find().sort("name").exec (err, result) ->
    myCallback err, result
    return



exports.getModels = (param = {}, myCallback) ->
  condition = {}
  async.waterfall [
    (callback) ->
      if param.params.make?
        callback null, param.params.make
      else
        callback null, null
    (make, callback) ->
      if param.params.year?
        AutoYear.findOneByYear(param.params.year).exec (err, year) ->
          callback null, make, year
          return

      else
        callback null, make, null
  ], (err, make, year) ->
    condition["id_make"] = make  if make?
    condition["idYear"] = year.id  if year?
    AutoModel.find(condition).sort("name").exec (err, resul) ->
      myCallback err, resul
      return

    return

  return


exports.getInfoModels = (param = {}, myCallback) ->
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
        myCallback null, null
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

          myCallback null, ret
          return

      return

  return



#Import
exports.insertParamCar = (options) ->
  ii = parseInt(options.y)
  fs = require("fs")
  dir = "autoTrim/" + ii + ".txt"
  fs.readFile dir, "utf8", (err, data) ->
    return console.log(err)  if err
    data = data.substr(0, data.length - 1)
    model = JSON.parse("[" + data + "]")

    #console.log(model);
    model.forEach (val, i) ->

      #console.log(val);
      async.waterfall [
        (callback) ->
          AutoYear.findOneByYear ii, callback
        (year, callback) ->
          AutoMake.findOneByMake_uid val.model_make_id, (err, res) ->
            callback null, year, res
            return

        (year, make, callback) ->
          return  unless make?
          AutoModel.findOne
            id_make: make.id
            name: val.model_name
            idYear: year.id
          , (err, model_car) ->
            callback null, year, model_car
            return

      ], (err, year, model_car) ->
        model2 = val
        console.log year, model_car
        return  unless model_car?
        val.model_id_url = val.model_id
        val.model_year = year.id
        val.model_make_id = model_car.id_make
        val.model_id = model_car.id

        #console.log(model2);
        #                 var merge = require('merge')
        #                 var out = merge(model2, val );

        #console.log("----------out-----------", val)
        AutoParam.create val, console.log
        return

      return

    return


  # Сейчас результат будет равен 'Готово'
  res.send "vinGet"
  return

exports.insertModelsCar = (options) ->
  g_i = parseInt(options.y)
  request = require("request")
  request "http://my-way.bl.ee/" + g_i + ".txt", (error, response, request) ->
    model = JSON.parse("[" + request + "{}]")
    console.log g_i
    AutoYear.findOneByYear g_i, (i, y) ->
      model.forEach (v, i) ->
        if v.model_make_id?
          AutoMake.findOneByMake_uid v.model_make_id, (data, t) ->

            #console.log(t.id);
            AutoModel.find().where(
              name: v.model_name
              idYear: y.id
            ).limit(1).exec userCreated = (err, car) ->

              #console.log(err, car.length)
              if car? and car.length > 0
                AutoModel.update car.id,
                  name: v.model_name
                  id_make: t.id
                  idYear: y.id
                  certified: 1
                , afterwards = (err, updated) ->
                    console.log "updated: ", updated
                    return

              else
                AutoModel.create
                  name: v.model_name
                  id_make: t.id
                  idYear: y.id
                  certified: 1
                , (error, response) ->

              return

            return

        return

      return

    return


  #console.log(error, response)
  res.send "<a href='/get/vin?y=" + (g_i + 1) + "'>" + (g_i + 1) + "</a>"