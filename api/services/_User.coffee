
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

  addFile:  (data = {}, req, callback) ->
    Files.create
      uid_user: req.session.user
      filename: data.filename
      type: data.type
      size: data.size
      fd: data.fd
    , (error, response) ->
        callback response

  deleteFile: (id, req, callback) ->

module.exports = new _User