###*
Created by Ihor on 27.09.2014.
###
exports.getInfoVin = (code, myCallback) ->
  console.log code
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
        if res? and res.status? and res.status is "NOT_FOUND"
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