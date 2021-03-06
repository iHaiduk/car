
module.exports =
  connection: "someMysqlServer"
  tableName: "auto_year"
  schema: true

  autoPK: false

  autoCreatedAt: false
  autoUpdatedAt: false
  attributes:
    id:
      type: "integer"
      primaryKey: true
      autoIncrement: true

    year:
      type: "integer"
      size: 4
      unique: true

    idModel:
      collection: "AutoModel"
      via: "idYear"

    params:
      collection: "AutoParam"
      via: "model_year"

    vin:
      collection: "AutoVin"
      via: "idYear"