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

        async.waterfall([
            function (callback) {
                AutoMake.find().populate('models',{sort: "name"}).sort('name').exec(callback);
            },
            function (make, callback) {
                make.forEach(function(val, i){
                    make[i].models = unique(make[i].models);
                });
                //console.log(make[0].models);
                callback(null, make);
            }
        ], function (err, results) {
            //console.log(err, results);
            res.view('settings/index', {makes : results});
        });
        /*async.series({
                makes: function(callback){
                    AutoMake.find().sort('name').exec(function(){});
                },
                models: function(callback){
                    AutoModel.find().sort('name').exec(function(err, res){
                        callback(null, unique(res));
                    });
                }
            },
            function(err, results) {
                console.log(err, results);
                res.view('settings/index', results);
            });*/
        /*{
            one: function(callback){
                AutoMake.find().sort('name').exec(callback);
            },
            two: function(callback){
                AutoModel.find().sort('name').exec(callback);
            }
        },*/
        /*var make = AutoMake.find().sort('name').exec(function(i, val){
            //console.log(i, val);
            res.view('settings/index', {make: val, test : "A"});
        });*/
        //res.view();
    },
    getVin: function(req, res) {
        //var code = "1N4AL3AP4DC295509";
        var code = req.query.vin;
        Car.getInfoVin(code, function(result){
            //console.log(result, res);
            res.json(result);
        });
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

