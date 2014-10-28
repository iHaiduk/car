###*
User.js

@description :: TODO: You might write a short summary of how this model works and what it represents here.
@docs        :: http://sailsjs.org/#!documentation/models
###
module.exports =
  connection: "someMysqlServer"
  tableName: "user_car"
  schema: true
  autoPK: false

  autoCreatedAt: false
  autoUpdatedAt: false
  attributes:
    id:
      type: "integer"
      primaryKey: true
      autoIncrement: true

    user_id:
      model: "User"

    make_id:
      model: "AutoMake"

    model_id:
      model: "AutoModel"

    position:
      type: "integer"

    vinCode:
      type: "string"

    make_name:
      type: "string"

    model_name:
      type: "string"

    model_year:
      type: "integer"
      size: 4

    model_transmission_type:
      type: "string"
    model_transmission_type_check:
      type: "integer"
      defaultsTo: "0"
      max: 1

    model_body:
      type: "string"
    model_body_check:
      type: "integer"
      defaultsTo: "0"
      max: 1

    region:
      type: "string"
    region_check:
      type: "integer"
      defaultsTo: "0"
      max: 1

    country:
      type: "string"
    country_check:
      type: "integer"
      defaultsTo: "0"
      max: 1

    model_drive:
      type: "string"
    model_drive_check:
      type: "integer"
      defaultsTo: "0"
      max: 1

    model_engine_type:
      type: "string"
    model_engine_type_check:
      type: "integer"
      defaultsTo: "0"
      max: 1

    model_engine_position:
      type: "string"
    model_engine_position_check:
      type: "integer"
      defaultsTo: "0"
      max: 1

    model_engine_cyl:
      type: "string"
    model_engine_cyl_check:
      type: "integer"
      defaultsTo: "0"
      max: 1

    model_engine_cc:
      type: "string"
    model_engine_cc_check:
      type: "integer"
      defaultsTo: "0"
      max: 1

    model_engine_valves_per_cyl:
      type: "string"
    model_engine_valves_per_cyl_check:
      type: "integer"
      defaultsTo: "0"
      max: 1

    model_engine_ci:
      type: "string"
    model_engine_ci_check:
      type: "integer"
      defaultsTo: "0"
      max: 1

    model_engine_torque_rpm:
      type: "string"
    model_engine_torque_rpm_check:
      type: "integer"
      defaultsTo: "0"
      max: 1

    model_engine_fuel:
      type: "string"
    model_engine_fuel_check:
      type: "integer"
      defaultsTo: "0"
      max: 1

    model_lkm_hwy:
      type: "string"
    model_lkm_hwy_check:
      type: "integer"
      defaultsTo: "0"
      max: 1

    model_lkm_city:
      type: "string"
    model_lkm_city_check:
      type: "integer"
      defaultsTo: "0"
      max: 1

    model_fuel_cap_l:
      type: "string"
    model_fuel_cap_l_check:
      type: "integer"
      defaultsTo: "0"
      max: 1

    model_length_mm:
      type: "string"
    model_length_mm_check:
      type: "integer"
      defaultsTo: "0"
      max: 1

    model_width_mm:
      type: "string"
    model_width_mm_check:
      type: "integer"
      defaultsTo: "0"
      max: 1

    model_height_mm:
      type: "string"
    model_height_mm_check:
      type: "integer"
      defaultsTo: "0"
      max: 1

    model_weight_kg:
      type: "string"
    model_weight_kg_check:
      type: "integer"
      defaultsTo: "0"
      max: 1
