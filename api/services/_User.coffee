
class _User
  constructor: (@user = {}) ->
    @user.id = null;

  login: (data = {}, callback) ->
    @user.id = data.session.user = 1
    callback()

  create:  (data = {}, callback) ->
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
      data.make_id = if not data.make_id? or not _Car.isInteger(data.make_id) then null else data.make_id
      data.model_id = if not data.make_id? or not data.model_id? or not _Car.isInteger(data.model_id) then null else data.model_id
      UserCar.update({user_id: @user.id, position: 1}, data).exec (err, res) ->
        callback err, null  if callback and typeof (callback) is "function"
      return
    else
      console.log "Need authorization! "+sails.getBaseurl()+"/user/login"
      callback null, null if callback and typeof (callback) is "function"
#console.log data

module.exports = new _User