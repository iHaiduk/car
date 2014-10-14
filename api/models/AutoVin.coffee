###*
Created by Ihor on 27.09.2014.
###
module.exports =
  connection: "someMysqlServer"
  tableName: "auto_vin"
  schema: true

# Disables Automatic ID generation
# (allows you to use a FLOAT type for your ID)
  autoPK: false

# Disables Automatic Timestamps
# You will need to manually update your timestamps, usually best to leave this
# on and remove the updated_at and created_at attributes below to let Waterline
# keep these up to date for you
  autoCreatedAt: false
  autoUpdatedAt: false
  attributes:
    id:
      type: "integer"
      primaryKey: true
      autoIncrement: true

    code:
      type: "string"
      size: 17

    idYear:
      model: "AutoYear"

    idMake:
      model: "AutoMake"

    idModel:
      model: "AutoModel"