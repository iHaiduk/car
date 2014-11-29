
class _User
  constructor: (@user = {}) ->
    @user.id = null;

  login: (data = {}, callback) ->
    @user.id = data.session.user = 1
    callback()

  create: (data = {}, callback) ->
    passwordHash = require 'password-hash'
    md5 = require 'MD5'

    leng = if 5 < data.email.length < 30 then data.email.length else 21

    md5_gen = md5(data.email + "!Hiv")[0..leng]

    password = passwordHash.generate datate
      email: data.email
      password: password
      fio: data.fio
      phone: data.phone
      salt: md5_gen
    , (error, response) ->
      callback error, response
    return

  setUserCar: (session, data, callback) ->
    if @user.id isnt null
      delete data.id
      delete data.user_id
      delete data.position
      data.make_id = if not data.make_id? or parseInt(data.make_id) < 1 then null else parseInt(data.make_id)
      data.model_id = if not data.make_id? or not data.model_id?  or parseInt(data.model_id) < 1 then null else parseInt(data.model_id)
      UserCar.update({user_id: @user.id, position: 1}, data).exec (err, res) ->
        callback err, null  if callback and typeof (callback) is "function"
      return
    else
      console.log "Need authorization! "+sails.getBaseurl()+"/user/login"
      callback null, null if callback and typeof (callback) is "function"

  getUserCar: (param, callback) ->
    param.body.uid_car = param.body.user_car
    param.body.uid_user = param.session.user
    param.body.part_number = (if param.body.part_number is "" or not param.body.part_number? then null else parseInt(param.body.part_number))
    param.body.group_of_spare_parts = parseInt(param.body.group_of_spare_parts)
    param.body.type_of_spare_parts = parseInt(param.body.type_of_spare_parts)
    param.body.condition_parts = parseInt(param.body.condition_parts)
    param.body.link_item = null if param.body.link_item is ""
    param.body.files = null if param.body.files is ""
    Request.create param.body, (err,result) ->
      now = new Date(parseInt(result.time) * 1000)
      result.time = now.format("DD.MM.Y h:mm")
      UserCar.find(result.uid_car).exec (err, car) ->
        callback
          error: err
          result: result
          car: car[0].make_name + " " + car[0].model_name

  addFile:  (data = {}, req, callback) ->
    path = require('path')
    Files.create
      uid_user: req.session.user
      filename: data.filename
      type: data.type
      size: data.size
      code: path.basename data.fd, path.extname(data.fd)
      extname: path.extname data.fd
    , (error, response) ->
        callback response
    return

  deleteFile: (param, req, callback) ->
    Files.findOne(param).exec (err, data)->
      if data?
        Files.destroy(data.id).exec (err) ->
          fs = require "fs"
          dd = fs.unlinkSync "./upload/"+data.code+data.extname
          return
        return
    callback()

module.exports = new _User
