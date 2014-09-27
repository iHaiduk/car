/**
 * Created by gamePC on 26.09.2014.
 */
module.exports = {

    connection: 'someMysqlServer',
    tableName: 'auto_param',
    schema: true,

    // Disables Automatic ID generation
    // (allows you to use a FLOAT type for your ID)
    autoPK: false,

    // Disables Automatic Timestamps
    // You will need to manually update your timestamps, usually best to leave this
    // on and remove the updated_at and created_at attributes below to let Waterline
    // keep these up to date for you
    autoCreatedAt: false,
    autoUpdatedAt: false,

    attributes: {
        id: {
            type: 'integer',
            primaryKey: true,
            autoIncrement: true
        },
        model_id: {
            model:'AutoModel'
        },
        model_make_id: {
            model:'AutoMake'
        },
        model_year: {
            model:'AutoYear'
        },
        model_trim: "string",
        model_body: "string",
        model_engine_position: "string",
        model_engine_type: "string",
        model_engine_compression: "string",
        model_engine_fuel: "string",
        model_drive: "string",
        model_transmission_type: "string",
        model_id_url: "integer",
        model_engine_cc: "integer",
        model_engine_cyl: "integer",
        model_engine_power_ps: "integer",
        model_engine_power_rpm: "integer",
        model_engine_torque_nm: "integer",
        model_engine_torque_rpm: "integer",
        model_engine_ci: "integer",
        model_engine_power_kw: "integer",
        model_engine_valves: "integer",
        model_engine_torque_kgm: "integer",
        model_top_speed_kph: "integer",
        model_seats: "integer",
        model_doors: "integer",
        model_weight_kg: "integer",
        model_length_mm: "integer",
        model_width_mm: "integer",
        model_height_mm: "integer",
        model_wheelbase_mm: "integer",
        model_top_speed_mph: "integer",
        model_weight_lbs: "integer",
        model_engine_valves_per_cyl: {type:"integer", size:2},
        model_engine_l: "float",
        model_engine_bore_mm: "float",
        model_engine_stroke_mm: "float",
        model_0_to_100_kph: "float",
        model_fuel_cap_g: "float",
        model_fuel_cap_l: "float",
        model_lkm_hwy: "float",
        model_lkm_city: "float",
        model_lkm_mixed: "float"
    }
};