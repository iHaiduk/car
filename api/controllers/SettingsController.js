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
        /*var request = require('request');
         request('http://my-way.bl.ee/1940.txt', function (error, response, request) {
         request = JSON.parse("["+request.substr(0,-1)+"]");
         console.log(request);
         });
         return;*/
        // todo 1950 IN database
        var model =[];

        AutoYear.findOneByYear(1950, function(i, y) {

            model.forEach(function (v, i) {
                AutoMake.findOneByMake_uid(v.model_make_id, function (data, t) {
                    //console.log(t.id);
                    /*AutoModel.create({
                     name: v.model_name,
                     id_make: t.id,
                     idYear: yer_n,
                     certified: 1
                     }, function (error, response) {
                     console.log("created: " + v.model_name + "(" + response.id + ")")
                     });*/
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
        });
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

