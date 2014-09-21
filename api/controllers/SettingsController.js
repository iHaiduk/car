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
    }
};

