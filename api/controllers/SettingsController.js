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
            "vendor/selectize/selectize.bootstrap3.css",
            "styles/style.css"
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
            "vendor/selectize/selectize.js",
            "controlScript/settingsIndex.js"
        ];

        /*async.waterfall([
                function(callback){
                    AutoMake.find().sort('name').exec(callback);
                },*//*
                function(makes, callback){
                    AutoYear.findOneByYear(2014,function(err, year){
                        callback(null, makes, year);
                    });
                },*//*
                *//*function(makes, callback){
                    AutoModel.find({id_make: makes[0].id}).sort('name').exec(function(err, res){
                        callback(null, makes, unique(res));
                    });
                }
            ],
            function(err, makes, models) {
         res.view('settings/index', {makes : makes, models: models});
            });*/
        res.view('settings/index');
    },
    getVin: function(req, res) {
        //var code = "1N4AL3AP4DC295509";
        var code = req.query.vin | "1N4AL3AP4DC295509";
        Car.getInfoVin(code, function(result){
            //console.log(result, res);
            res.json(result);
        });
    },
    getMakes: function(req, res) {
        AutoMake.find().sort('name').exec(function(err,result){
            res.json(result);
        });
    },
    getModels: function(req, res) {

        var condition = {};

        async.waterfall([
                function(callback){
                    if(req.params.make!= undefined)
                        callback(null,req.params.make)
                    else
                        callback(null,null)
                },function(make, callback){
                    if(req.params.year!= undefined)
                        AutoYear.findOneByYear(req.params.year).exec(function(err, year){
                            callback(null,make, year)
                        });
                    else
                        callback(null,make, null)
                }
            ],
            function(err, make, year) {
                if(make != null)
                    condition["id_make"] = make;
                if(year != null)
                    condition["idYear"] = year.id;

                AutoModel.find(condition).sort('name').exec(function(err, resul){
                    res.json(unique(resul));
                });
            });
    },
    getInfoModels: function(req, res) {
        var id = req.params.id,
            year = req.params.year,
            type= req.params.type;
        if(type == "id"){
            async.waterfall([
                   function(callback){
                        if(req.params.year!= undefined)
                            AutoYear.findOneByYear(req.params.year).exec(function(err, year){
                                callback(null, year)
                            });
                        else
                            callback(null, null)
                    }
                ],
                function(err, year) {
                    if(year == null)
                        res.json({});
                    else
                        AutoParam.find({model_id: id, model_year: year.id}).exec(function(err, resul){
                            console.log(err, resul)
                            res.json(resul);
                        });
                });
        }
    }
};

function unique(arr) {
    var obj = {},
        objs = [];
    var k = 0;
    for(var i=0; i<arr.length; i++) {
        var str = arr[i].name;
        if(obj[str]==undefined) {
            objs[k] = arr[i];
            k++;
        }
        obj[str] = true; // запомнить строку в виде свойства объекта
    }
    return objs; // или собрать ключи перебором для IE<9
}

