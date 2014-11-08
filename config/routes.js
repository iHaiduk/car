module.exports.routes = {

    /* TODO MAIN */
    '/': {
        controller: 'PromoController',
        action: 'promo'
    },
    '/panel':  {
        controller: 'PromoController',
        action: 'index'
    },

    /* TODO SETTINGS */
    '/settings': {
        controller: 'SettingsController',
        action: 'index'
    },
    '/get/vin': {
        controller: 'SettingsController',
        action: 'getVin'
    },
    '/get/makes/': {
        controller: 'SettingsController',
        action: 'getMakes'
    },
    '/get/models/:make/:year': {
        controller: 'SettingsController',
        action: 'getModels'
    },
    '/get/info/models/:type/:id/:year': {
        controller: 'SettingsController',
        action: 'getInfoModels'
    },
    '/set/param': {
        controller: 'SettingsController',
        action: 'setParam'
    },

    /* TODO USER */
    '/user/new':{
        controller: 'UserController',
        action: 'new'
    },
    '/user/login':{
        controller: 'UserController',
        action: 'login'
    },

    /* TODO REQUEST */
    '/myrequest':{
        controller: 'RequestController',
        action: 'getRequest'
    },

    /* TODO FILE */
    '/upload':{
        controller: 'UploadController',
        action: 'upload'
    },
    '/upload/file':{
        controller: 'UploadController',
        action: 'uploadFile'
    }
};
