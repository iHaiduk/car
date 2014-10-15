###*
User.js

@description :: TODO: You might write a short summary of how this model works and what it represents here.
@docs        :: http://sailsjs.org/#!documentation/models
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
