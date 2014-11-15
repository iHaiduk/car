module.exports =
  connection: "someMysqlServer"
  tableName: "request"
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
    uid_car:
      model: "UserCar"

    required_item:
      type: "string"

    part_number:
      type: 'integer'

    group_of_spare_parts:
      type: 'integer'
      size: 3

    type_of_spare_parts:
      type: 'integer'
      size: 1

    condition_parts:
      type: 'integer'
      size: 1

    delivery_time:
      type: 'string'
      size: 25

    link_item:
      type: 'string'

    files:
      type: 'string'
      size: 100

    time:
      type: 'string'
      defaultsTo: ->
        parseInt(new Date().getTime()/1000)
