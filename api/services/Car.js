/**
 * Created by Ihor on 27.09.2014.
 */
exports.getInfoVin = function(code, myCallback) {
    async.waterfall([
        function (callback) {
            AutoVin.findOneByCode(code, function(err, res){
                if(res == undefined || res.idYear == undefined) callback();
                else return myCallback({year: res.idYear, make: res.idMake, model: res.idModel});
            });
        },
        function (callback) {
            var vin = require('vin'); // http://www.decodethis.com/
            vin.lookup(code, function(vehicle) {
                if(vehicle.model != undefined) {
                    return myCallback({year: vehicle.year, make: vehicle.make, model: vehicle.model});
                }else callback();
            });
        },
        function (callback) {
            var EdmundsClient = require('node-edmunds-api'); // http://developer.edmunds.com/
            var client = new EdmundsClient({ apiKey: 'zsx3jzwjkk9ke7zq4ze9mjp3' }); // zsx3jzwjkk9ke7zq4ze9mjp3
            client.decodeVin({ vin: code }, function(err, res) {
                if(res.status != 'NOT_FOUND') {
                    return myCallback({year: res.years[0].year, make: res.make.name, model: res.model.name});
                }else callback();
            });
        }
    ], function () {
        return myCallback({year: null, make: null, model: null});
    });
};
exports.insertParamCar = function(options) {
    var ii = parseInt(options.y);

    var fs=require('fs');
    var dir = 'autoTrim/'+ii+'.txt';

    fs.readFile(dir, 'utf8', function (err, data) {
        if (err) {
            return console.log(err);
        }
        data = data.substr(0, data.length - 1);
        var model = JSON.parse('[' + data + ']');
        //console.log(model);
        model.forEach(function (val, i) {
            //console.log(val);
            async.waterfall([
                function (callback) {
                    AutoYear.findOneByYear(ii, callback);
                },
                function (year, callback) {
                    AutoMake.findOneByMake_uid(val.model_make_id, function (err, res) {
                        callback(null, year, res);
                    });
                },
                function (year, make, callback) {
                    if(make == undefined) return;
                    AutoModel.findOne({
                        id_make: make.id,
                        name: val.model_name,
                        idYear: year.id
                    }, function (err, model_car) {
                        callback(null, year, model_car);
                    });
                }
            ], function (err, year, model_car) {
                var model2 = val;

                console.log(year, model_car)
                if(model_car == undefined) return;

                val.model_id_url = val.model_id;
                val.model_year = year.id;
                val.model_make_id = model_car.id_make;
                val.model_id = model_car.id;


                /*console.log(model2);
                 var merge = require('merge')
                 var out = merge(model2, val );*/

                //console.log("----------out-----------", val)
                AutoParam.create(val, console.log);

                // Сейчас результат будет равен 'Готово'
            });
        });

    });

    res.send('vinGet');

};

exports.insertModelsCar =  function(options) {

    var g_i = parseInt(options.y);

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
};