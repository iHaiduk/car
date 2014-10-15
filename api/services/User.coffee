
exports.create = (data = {}, callback) ->


  passwordHash = require 'password-hash'
  md5 = require 'MD5'

  md5_gen = md5 Math.random()

  password = passwordHash.generate data.password + md5_gen, null, 5

  UserModel.create
    email: data.email
    password: password
    fio: data.fio
    phone: data.phone
    salt: md5_gen
  , (error, response) ->
      callback error, response
  return
