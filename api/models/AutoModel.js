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
<<<<<<< HEAD
=======
        name: {
            type: "string",
            unique: true
        },
>>>>>>> 0c5c054fb5918777a179c3d7f91a5a80ae24a2a1
        id_make: {
            model:'AutoMake'
        },
        name: "string",
        certified: "integer",
        idYear: {
            model:'AutoYear'
        },
        AutoEngineCompressorType:{
            collection: 'AutoEngineCompressorType',
            via: 'idModel'
        },
        AutoEngineCylinder:{
            collection: 'AutoEngineCylinder',
            via: 'idModel'
        },
        AutoEngineFuelType:{
            collection: 'AutoEngineFuelType',
            via: 'idModel'
        },
        AutoEngineSize:{
            collection: 'AutoEngineSize',
            via: 'idModel'
        },
        AutoEngineType:{
            collection: 'AutoEngineType',
            via: 'idModel'
        },
        AutoStyle:{
            collection: 'AutoStyle',
            via: 'idModel'
        },
        AutoTransmissionType:{
            collection: 'AutoTransmissionType',
            via: 'idModel'
        },
        AutoYear:{
            collection: 'AutoYear',
            via: 'idModel'
        },
        AutoVin:{
            collection: 'AutoVin',
            via: 'modelName'
        }
    }
};



