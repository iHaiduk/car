/**
 * SettingsController
 *
 * @description :: Server-side logic for managing settings
 * @help        :: See http://links.sailsjs.org/docs/controllers
 */

module.exports = {
    index: function(req, res){
        res.locals.styles = [
            "vendor/slider/css/slider.css",
            "vendor/chosen/chosen.min.css",
            "vendor/datetimepicker/css/bootstrap-datetimepicker.min.css",
            "vendor/codemirror/lib/codemirror.css",
            "vendor/tagsinput/bootstrap-tagsinput.css",
        ];
        res.locals.scripts = [
            "vendor/formwizard/js/bwizard.min.js",
            "vendor/codemirror/lib/codemirror.js",
            "vendor/codemirror/addon/mode/overlay.js",
            "vendor/codemirror/mode/markdown/markdown.js",
            "vendor/codemirror/mode/xml/xml.js",
            "vendor/codemirror/mode/gfm/gfm.js",
            "vendor/marked/marked.js",
            "vendor/parsley/parsley.min.js",
            "vendor/moment/min/moment-with-langs.min.js",
            "vendor/datetimepicker/js/bootstrap-datetimepicker.min.js",
            "vendor/tagsinput/bootstrap-tagsinput.min.js",
            "vendor/inputmask/jquery.inputmask.bundle.min.js",
            "vendor/validation/jquery.validate.js",
            "controlScript/settingsIndex.js"
        ];
        res.view();
    },

    vinGet: function(req, res) {
        var year_start = 1940;

        // http://fastcodenote.blogspot.com/2013/09/nodejs-async.html

        var async = require("async");
        /*var taskNamed = {
            viewsNumber: function (callback) {
                AutoYear.findOneByYear(1940).exec(callback);
            }
            , growFactor: function (callback) {
                callback(null, 1212412);
            }
        };
        async.series(taskNamed, function (err, results) {
            // Результат будет объектом
            console.log(results); // {viewsNumber: 231, growFactor: 24}
        });*/

        async.waterfall([
            function(callback){
                callback(null, 'один', 'два');
            },
            function(arg1, arg2, callback){
                // Тут arg1 равен "один"
                // , а arg2 равен "два"
                // что соответствует второму и третьему параметру текщего колбека
                // , а первый конечно же мы не забыли - это err но в этом случае
                // ошибок нет поэтому null
                console.log(arg1, arg2);
                callback(null, 'три');
            },
            function(arg1, callback){
                // Здесь же arg1 будет равен уже "три"
                console.log(arg1);
                callback(null, 'Готово');
            }
        ], function (err, result) {
            console.log(err, result);
            // Сейчас результат будет равен 'Готово'
        });

        res.send('vinGet');

    },

    test: function(err, data){
        console.log(err, data);
    },

    insertModelsCar: function(req, res) {

        var g_i = parseInt(req.query.y);

            var request = require('request');
            request('http://my-way.bl.ee/' + g_i + '.txt', function (error, response, request) {
                var model = JSON.parse('[' + request + '{}]');
                console.log(g_i)
                AutoYear.findOneByYear(g_i, function (i, y) {

                    model.forEach(function (v, i) {
                        if(v.model_make_id != undefined)
                            AutoMake.findOneByMake_uid(v.model_make_id, function (data, t) {
                                //console.log(t.id);
                                AutoModel.find().where({
                                    name: v.model_name,
                                    idYear: y.id
                                }).limit(1).exec(function userCreated(err, car) {
                                    //console.log(err, car.length)
                                    if (car != undefined && car.length > 0)
                                        AutoModel.update(car.id, {
                                            name: v.model_name, id_make: t.id, idYear: y.id, certified: 1
                                        }, function afterwards(err, updated) {
                                            console.log("updated: ", updated);
                                        });
                                    else
                                        AutoModel.create({
                                            name: v.model_name,
                                            id_make: t.id,
                                            idYear: y.id,
                                            certified: 1
                                        }, function (error, response) {
                                            //console.log(error, response)
                                        });
                                });
                            });
                    });
                });
            });
        return res.send("<a href='/get/vin?y="+(g_i+1)+"'>"+(g_i+1)+"</a>");



        /*AutoYear.findOneByYear(1961, function(i, y) {

            model.forEach(function (v, i) {
                AutoMake.findOneByMake_uid(v.model_make_id, function (data, t) {
                    //console.log(t.id);
                    *//*AutoModel.create({
                     name: v.model_name,
                     id_make: t.id,
                     idYear: yer_n,
                     certified: 1
                     }, function (error, response) {
                     console.log("created: " + v.model_name + "(" + response.id + ")")
                     });*//*
                    AutoModel.find().where({name: v.model_name, idYear:y.id}).limit(1).exec(function userCreated(err, car) {
                        //console.log(err, car.length)
                        if (car != undefined && car.length > 0)
                            AutoModel.update(car.id, {
                                name: v.model_name, id_make: t.id, idYear: y.id, certified: 1
                            }, function afterwards(err, updated) {
                                console.log("updated: ", updated);
                            });
                        else
                            AutoModel.create({name: v.model_name, id_make: t.id, idYear: y.id, certified: 1},function(error, response){
                                //console.log(error, response)
                            });
                    });
                });
            });
        });*/
        /*ttt();
        function ttt(){
        clearTimeout(timeout);
        AutoMake.findOneByMake_uid(make[car], function(data, t){
        if(t != undefined) var make_id = t.id;
        request('http://www.carqueryapi.com/api/0.3/?cmd=getModels&make=' + make[car] + '&year=' + years[0], function (error, response, request) {
        console.log(request);
        *//*AutoModel.create({name:"test", id_make: make_id, idYear: 1},function(error, response){
        console.log(error, response)
        });*//*
        var time = 5000 + Math.random()*2000;
        console.log(car,time);
        if(car<3*//*make.length*//*){
        car++;
        timeout = setTimeout(ttt(), time);
        }
        });
        });
        }*/

        /*request('http://www.carqueryapi.com/api/0.3/?cmd=getMakes&year='+year, function (error, response, request) {
        request = JSON.parse(request).Makes;
        request.forEach(function (val, i) {
        AutoMake.findOneByName(val.make_display).exec(function userCreated(err, car) {
        //console.log(err, car); //return;
        if (car != undefined)
        AutoMake.update(car.id, {
        country: val.make_country,
        make_uid: val.make_id
        }, function afterwards(err, updated) {
        //console.log(err, updated[0].id);
        });
        else
        AutoMake.create({
        name: val.make_display,
        idMake: null,
        country: val.make_country,
        make_uid: val.make_id
        }, function userCreated(err, user) {
        //console.log(err, user);
        });
        });
        });
        year++;
        var time = 2000 + Math.random()*2000;
        console.log(year,time);
        //if(year<=2015) setTimeout(tet, time);
        });*/
    }
};

