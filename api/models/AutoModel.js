/**
 * AutoModel.js
 *
 * @description :: TODO: You might write a short summary of how this model works and what it represents here.
 * @docs        :: http://sailsjs.org/#!documentation/models
 */

module.exports = {

    connection: 'someMysqlServer',
    tableName: 'auto_model',
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
        id_make: {
            model:'AutoMake'
        },
        name: "string",
        certified: "integer",
        idYear: {
            model:'AutoYear'
        },
        params:{
            collection: 'AutoParam',
            via: 'model_id'
        },
        vin:{
            collection: 'AutoVin'
        }
    }
};



