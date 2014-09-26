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

        var model = [{"model_id":"48585","model_make_id":"alfa-romeo","model_name":"6C","model_trim":"","model_year":"1940","model_body":null,"model_engine_position":"Front","model_engine_cc":"2442","model_engine_cyl":"6","model_engine_type":"in-line","model_engine_valves_per_cyl":"2","model_engine_power_ps":"90","model_engine_power_rpm":"4600","model_engine_torque_nm":null,"model_engine_torque_rpm":null,"model_engine_bore_mm":"72.0","model_engine_stroke_mm":"100.0","model_engine_compression":null,"model_engine_fuel":"Gasoline","model_top_speed_kph":null,"model_0_to_100_kph":null,"model_drive":"Rear","model_transmission_type":"Manual","model_seats":"5","model_doors":"4","model_weight_kg":"1500","model_length_mm":"4880","model_width_mm":"1840","model_height_mm":"1510","model_wheelbase_mm":"3010","model_lkm_hwy":null,"model_lkm_mixed":null,"model_lkm_city":null,"model_fuel_cap_l":"77","model_sold_in_us":"0","model_co2":null,"model_make_display":null,"make_display":"Alfa Romeo","make_country":"Italy"}/*,{"model_id":"47982","model_make_id":"buick","model_name":"Century","model_trim":"","model_year":"1940","model_body":"Sedan","model_engine_position":"Front","model_engine_cc":"5247","model_engine_cyl":"8","model_engine_type":"in-line","model_engine_valves_per_cyl":null,"model_engine_power_ps":"167","model_engine_power_rpm":"3200","model_engine_torque_nm":null,"model_engine_torque_rpm":null,"model_engine_bore_mm":"86.3","model_engine_stroke_mm":"108.2","model_engine_compression":null,"model_engine_fuel":"Gasoline","model_top_speed_kph":"153","model_0_to_100_kph":null,"model_drive":"Rear","model_transmission_type":null,"model_seats":"5","model_doors":"4","model_weight_kg":null,"model_length_mm":null,"model_width_mm":null,"model_height_mm":null,"model_wheelbase_mm":null,"model_lkm_hwy":null,"model_lkm_mixed":null,"model_lkm_city":null,"model_fuel_cap_l":null,"model_sold_in_us":"1","model_co2":null,"model_make_display":null,"make_display":"Buick","make_country":"USA"},{"model_id":"108","model_make_id":"abarth","model_name":"1300","model_trim":"Abarth","model_year":"1965","model_body":null,"model_engine_position":"Rear","model_engine_cc":"1280","model_engine_cyl":"4","model_engine_type":"in-line","model_engine_valves_per_cyl":null,"model_engine_power_ps":"139","model_engine_power_rpm":"7600","model_engine_torque_nm":null,"model_engine_torque_rpm":null,"model_engine_bore_mm":null,"model_engine_stroke_mm":null,"model_engine_compression":null,"model_engine_fuel":"Gasoline","model_top_speed_kph":null,"model_0_to_100_kph":null,"model_drive":"Rear","model_transmission_type":null,"model_seats":"2","model_doors":"2","model_weight_kg":"630","model_length_mm":"3560","model_width_mm":"1490","model_height_mm":"1140","model_wheelbase_mm":"2100","model_lkm_hwy":null,"model_lkm_mixed":null,"model_lkm_city":null,"model_fuel_cap_l":"30","model_sold_in_us":"0","model_co2":null,"model_make_display":null,"make_display":"Abarth","make_country":"Italy"}*/];

        model.forEach(function(val,i){
            async.waterfall([
                function(callback){
                    AutoYear.findOneByYear(parseInt(val.model_year),callback);
                },
                function(year, callback){
                    console.log(year);
                    AutoMake.findOneByMake_uid(val.model_make_id, function(err, res){
                        callback(null, year, res);
                    });
                }
            ], function (err, result, car) {
                console.log(err, result, car);
                // Сейчас результат будет равен 'Готово'
            });
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

