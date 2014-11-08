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

    filename:
        type: "string"

    size:
      type: 'integer'

    fd:
      type: 'string'

    time:
      type: 'integer'
