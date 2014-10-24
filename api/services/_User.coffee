
class _User
  constructor: (@user = {}) ->
    @user.id = null

  login: (data = {}, callback) ->
    @user.id = data.session.user = 1
    callback()

  create:  (data = {}, callback) ->
    passwordHash = require 'password-hash'
    md5 = require 'MD5'

    md5_gen = md5 Math.random()

    password = passwordHash.generate data.password + md5_gen, null, 5

    User.create
      email: data.email
      password: password
      fio: data.fio
      phone: data.phone
      salt: md5_gen
    , (error, response) ->
      callback error, response
    return

  setUserCar: (data = {}, callback) ->
    session = data.session
    _d = {}
    if data.make? then _d.make_id = data.make
    if data.model? then _d.model_id = data.model
    if data.year? then _d.model_year = data.year

    if @user.id isnt null
      console.log @user.id
      UserCar.update({user_id: @user.id, position: 1}, _d).exec (err, result)  ->
        console.log result
    else
      console.log "Need authorization! "+sails.getBaseurl()+"/user/login"
    #console.log data

module.exports = new _User