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
<<<<<<< HEAD
    vinGet: function(req, res) {
        /*console.log(req.query)
        return;*/
        /*var request = require('request');
        var years = [1940,1941,1942,1943,1944,1947,1945,1948,1946,1949,1950,1951,1953,1955,1952,1954,1956,1957,1958,1959,1960,1961,1962,1963,1964,1966,1965,1967,1968,1970,1971,1969,1972,1973,1974,1975,1976,1977,1980,1978,1979,1981,1982,1983,1984,1985,1987,1986,1989,1988,1990,1991,1992,1993,1994,1995,1997,1996,1998,1999,2001,2000,2002,2003,2004,2005,2007,2006,2008,2009,2010,2011,2012,2013,2014,2015];
        var make = ['am-general','acura','audi','bmw','bentley','bugatti','alfa-romeo','cadillac','chevrolet','aston-martin','buick','chrysler','daewoo','dodge','eagle','fiat','ferrari','ford','gmc','geo','hummer','honda','hyundai','infiniti','isuzu','jaguar','kia','jeep','land-rover','lamborghini','lexus','lincoln','lotus','mini','maserati','mclaren','mercedes-benz','mercury','mazda','mitsubishi','nissan','oldsmobile','pontiac','plymouth','rolls-royce','porsche','null','saab','saturn','scion','spyker','subaru','suzuki','tesla','toyota','volkswagen','volvo','smart','austin','citroen','dkw','gaz','lancia','maybach','opel','packard','morris','peugeot','renault','rover','simca','skoda','steyr','sunbeam','tatra','willys-overland','alvis','armstrong-siddeley','riley','alpina','alpine','auverland','bristol','beijing','caterham','ascari','de-tomaso','donkervoort','daihatsu','ginetta','holden','innocenti','italdesign','jensen','lada','lotec','mahindra','marcos','mg','monteverdi','morgan','proton','seat','tata','tvr','vauxhall','westfield','zastava','venturi','zagato','xedos','reliant','zaz','ac','pininfarina','ssangyong','vector','mcc','panoz','bizzarrini','noble','pagani','samsung','ariel','matra-simca','saleen','dacia','koenigsegg','avanti','studebaker','daimler','ssc','abarth','geely','brilliance','luxgen','zenvo','fisker'];*/

        /*request('http://www.carqueryapi.com/api/0.3/?cmd=getModels&make=' + make[13] + '&year=' + years[50], function (error, response, request) {
            console.log(request);

        });*/
        /*AutoMake.findOneByMake_uid('audi', function(data, t){
            var make_id = t.id;
            AutoModel.create({name:"test", id_make: make_id, idYear: 1},function(error, response){
                console.log(error, response)
            });
        });*/
        var yer_n = 6;
        /*var model = [
            {"model_name":"6C","model_make_id":"alfa-romeo"},{"model_name":"Century","model_make_id":"buick"}
            ];*/
        //1941
        /*var model = [
            {"model_name":"MK V","model_make_id":"bentley"},
            {"model_name":"Type 68","model_make_id":"bugatti"},
            {"model_name":"6C","model_make_id":"alfa-romeo"},
            {"model_name":"60","model_make_id":"cadillac"},
            {"model_name":"61","model_make_id":"cadillac"},
            {"model_name":"62","model_make_id":"cadillac"},
            {"model_name":"15","model_make_id":"aston-martin"},
            {"model_name":"2-Litre","model_make_id":"aston-martin"},
            {"model_name":"40","model_make_id":"buick"},
            {"model_name":"Century","model_make_id":"buick"},
            {"model_name":"Thunderbolt","model_make_id":"chrysler"},
            {"model_name":"500","model_make_id":"fiat"},
            {"model_name":"Taunus","model_make_id":"ford"},
            {"model_name":"SS","model_make_id":"jaguar"},
            {"model_name":"Zephyr","model_make_id":"lincoln"},
            {"model_name":"4","model_make_id":"maserati"},
            {"model_name":"8","model_make_id":"maserati"},
            {"model_name":"230","model_make_id":"mercedes-benz"},
            {"model_name":"320","model_make_id":"mercedes-benz"},
            {"model_name":"500","model_make_id":"mercedes-benz"},
            {"model_name":"770","model_make_id":"mercedes-benz"},
            {"model_name":"66","model_make_id":"oldsmobile"},
            {"model_name":"AA","model_make_id":"toyota"},
            {"model_name":"Schwimmwagen","model_make_id":"volkswagen"},
            {"model_name":"PV","model_make_id":"volvo"},
            {"model_name":"8","model_make_id":"austin"},
            {"model_name":"11","model_make_id":"citroen"},
            {"model_name":"15","model_make_id":"citroen"},
            {"model_name":"7A","model_make_id":"citroen"},
            {"model_name":"Reichklasse F8","model_make_id":"dkw"},
            {"model_name":"10-73","model_make_id":"gaz"},
            {"model_name":"61","model_make_id":"gaz"},
            {"model_name":"M1","model_make_id":"gaz"},
            {"model_name":"Aprilia","model_make_id":"lancia"},
            {"model_name":"SW","model_make_id":"maybach"},
            {"model_name":"Kraftfahrzeug","model_make_id":"opel"},
            {"model_name":"12","model_make_id":"packard"},
            {"model_name":"Ten Four","model_make_id":"morris"},
            {"model_name":"202","model_make_id":"peugeot"},
            {"model_name":"Type 202","model_make_id":"peugeot"},
            {"model_name":"Juva","model_make_id":"renault"},
            {"model_name":"P2","model_make_id":"rover"},
            {"model_name":"5","model_make_id":"simca"},
            {"model_name":"8","model_make_id":"simca"},
            {"model_name":"Polular 995","model_make_id":"skoda"},
            {"model_name":"Popular","model_make_id":"skoda"},
            {"model_name":"Superb","model_make_id":"skoda"},
            {"model_name":"220","model_make_id":"steyr"},
            {"model_name":"10","model_make_id":"sunbeam"},
            {"model_name":"2-Litre","model_make_id":"sunbeam"},
            {"model_name":"T87","model_make_id":"tatra"},
            {"model_name":"Jeep","model_make_id":"willys-overland"},
        ];*/
        //1942
        /*var model = [
            {"model_name":"Type 68","model_make_id":"bugatti"},{"model_name":"6C","model_make_id":"alfa-romeo"},{"model_name":"60","model_make_id":"cadillac"},{"model_name":"61","model_make_id":"cadillac"},{"model_name":"62","model_make_id":"cadillac"},{"model_name":"15","model_make_id":"aston-martin"},{"model_name":"Atom","model_make_id":"aston-martin"},{"model_name":"40","model_make_id":"buick"},{"model_name":"Century","model_make_id":"buick"},{"model_name":"Town & Country","model_make_id":"chrysler"},{"model_name":"WC 51","model_make_id":"dodge"},{"model_name":"500","model_make_id":"fiat"},{"model_name":"Taunus","model_make_id":"ford"},
        ];*/
        //1943
       /* var model = [{"model_name":"6C","model_make_id":"alfa-romeo"},{"model_name":"61","model_make_id":"cadillac"},{"model_name":"62","model_make_id":"cadillac"},{"model_name":"WC 51","model_make_id":"dodge"},{"model_name":"500","model_make_id":"fiat"},{"model_name":"Taunus","model_make_id":"ford"},]*/
        //1944
        /*var model = [{"model_name":"Type 68","model_make_id":"bugatti"},{"model_name":"6C","model_make_id":"alfa-romeo"},{"model_name":"61","model_make_id":"cadillac"},{"model_name":"62","model_make_id":"cadillac"},{"model_name":"WC 51","model_make_id":"dodge"},{"model_name":"500","model_make_id":"fiat"},{"model_name":"Taunus","model_make_id":"ford"},];*/
        //1945
        /*var model = [{"model_name":"Type 68","model_make_id":"bugatti"},{"model_name":"6C","model_make_id":"alfa-romeo"},{"model_name":"62","model_make_id":"cadillac"},{"model_name":"WC 51","model_make_id":"dodge"},{"model_name":"500","model_make_id":"fiat"},{"model_name":"Taunus","model_make_id":"ford"},];*/
/*
        var model = [];

        var model = [];

        var model = [];

        var model = [];

        var model = [];

        var model = [];

        var model = [];

        var model = [];

        var model = [];

        var model = [];*/
        model.forEach(function(v, i){
            AutoMake.findOneByMake_uid(v.model_make_id, function(data, t){
                //console.log(t.id);
                AutoModel.create({name: v.model_name, id_make: t.id, idYear: yer_n, certified: 1},function(error, response){
                    console.log("created: " + v.model_name+"("+response.id+")")
                });
                /*AutoModel.findOneByName(v.model_name).exec(function userCreated(err, car) {
                    if (car != undefined)
                        AutoModel.update(car.id, {
                            name: v.model_name, id_make: t.id, idYear: yer_n, certified: 1
                        }, function afterwards(err, updated) {
                            console.log("updated: "+updated[0].id);
                        });
                    else
                        AutoModel.create({name: v.model_name, id_make: t.id, idYear: yer_n, certified: 1},function(error, response){
                            console.log(error, response)
                        });
                });*/
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
=======
    vinGet: function(req, res){

        AutoMake.findByName("test",function (err, users) {
            console.log(err, users);
            /*if (err) {
                res.send(400);
            } else {
                res.send(users);
            }*/
        });
        /*var request = require('request');
        request('https://api.edmunds.com/v1/api/toolsrepository/vindecoder?vin=1N4AL3AP4DC295509&fmt=json&api_key=zsx3jzwjkk9ke7zq4ze9mjp3', function (error, response, request) {
            if (!error && response.statusCode == 200) {
                request = JSON.parse(request).styleHolder[0];
                Marques.create({name: "test"}, function userCreated(err, user) {
                    console.log(err, user)
                });
                return res.send(200, request); // Print the google web page.
            }
        })*/
>>>>>>> 0c5c054fb5918777a179c3d7f91a5a80ae24a2a1
    }
};

