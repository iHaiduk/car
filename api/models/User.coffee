module.exports =
  connection: "someMysqlServer"
  tableName: "users"
  schema: true

  autoCreatedAt: false
  autoUpdatedAt: false
  attributes:
    username:
      type: "string"
      required: true
      unique: true

    password:
      type: "string"
      required: true

    toJSON: ->
      obj = @toObject()
      delete obj.password

      obj


###
module.exports =
  connection: "someMysqlServer"
  tableName: "users"
  schema: true
  autoPK: false

  autoCreatedAt: false
  autoUpdatedAt: false
  attributes:
    id:
      type: "integer"
      primaryKey: true
      autoIncrement: true

    email:
      type: "email"
      unique: true
      required: true

    password:
      type: 'string'
      required: true
      minLength: 6

    fio:
      type: 'string'
      required: true

    phone:
      type: 'string'
      size: 15

    cars:
      collection: "UserCar"
      via: "user_id"

    files:
      collection: "Files"
      via: "uid_user"

    passports:
      collection: "Passport"
      via: "user"
###
