module.exports =
  connection: "someMysqlServer"
  tableName: "files"
  schema: true
  autoPK: false

  autoCreatedAt: false
  autoUpdatedAt: false
  attributes:
    id:
      type: "integer"
      primaryKey: true
      autoIncrement: true

    uid_user:
      model: "User"

    filename:
      type: "string"

    type:
      type: "string"

    size:
      type: 'integer'

    fd:
      type: 'string'

    time:
      type: 'integer'
      defaultsTo: ->
        new Date().getTime()

    used:
      type: "boolean"
      defaultsTo: 0
