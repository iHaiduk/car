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

    extname:
      type: 'string'

    code:
      type: 'string'

    time:
      type: 'string'
      defaultsTo: ->
        parseInt(new Date().getTime()/1000)

    used:
      type: "boolean"
      defaultsTo: 0
