
var globalGetreloadModels = null;

$(document).ready(function(){
    // Settings Page
    var vinSend = $("#vinSend"),
        vinId = $("#vinId"),
        yearSlide = $(".slider").slider(),
        make_select = $(".make_select"),
        firstLit=null;
    vinId.on("keyup focusout",function(){
        var text = $(this).val();
        var alNumRegex = /^([a-zA-Z0-9]+)$/; //only letters and numbers
        $(this).parent().removeClass("has-success has-error");
        vinSend.removeClass("btn-danger btn-success").find("i").removeClass("fa-check fa-times");
        if(text.length == 17 && alNumRegex.test(text)) {
            $(this).parent().addClass("has-success");
            vinSend.addClass("btn-success").find("i").addClass("fa-check");
        }
        else{
            $(this).parent().addClass("has-error");
            vinSend.addClass("btn-danger").find("i").addClass("fa-times");
        }
    });
    vinSend.click(function(){
        if($(this).hasClass("btn-success")){
            $.ajax({
                url: "/get/vin",
                type: "GET",
                data: {vin: vinId.val()},
                dataType: "json",
                success: function(data){
                    console.log(data)
                }
            });
        }
    });
    yearSlide.on('slideStop', function(){
        $("#settings_year h6").text(yearSlide.slider('getValue'));
        reloadModels(yearSlide);
    }).on('slide', function(){
        $("#settings_year h6").text(yearSlide.slider('getValue'));
    });

    $.get("/get/makes/", function(data){
        $("#selected_make").selectize({
            options: data,
            labelField: 'name',
            valueField: 'id',
            maxItems: 1,
            sortField: "name",
            persist: false,
            create: function(input) {
                return {
                    name: input,
                    id: input
                }
            },
            onChange: function() {
                reloadModels(yearSlide);
            },
            render: {
                option: function(data, escape) {
                    var make = escape(data.name);
                    var text = "";
                    if(firstLit != make[0].toUpperCase()){
                        if(firstLit!=null) text += "</div>";
                        text += '<div data-value="" data-selectable="false" data-group="'+make[0]+'" class="optgroup">' +
                        '<div class="optgroup-header">'+make[0]+'</div>';
                        firstLit = make[0].toUpperCase();
                    }
                    text += '<div data-value="' + escape(data.id) + '" data-selectable="" class="active-result group-option">' + make.charAt(0).toUpperCase() + make.substr(1)+ '</div>';
                    return text;
                },
                item:function(data, escape) {
                    return '<span class="tag label label-info">'+escape(data.name)+'</span>';
                }
            }
        });
    });
    $("#selected_models").selectize({
        labelField: 'name',
        valueField: 'id',
        maxItems: 1,
        sortField: "name",
        render: {
            option: function(data, escape) {
                var make = escape(data.name);
                var text = '<div data-value="' + escape(data.id) + '" data-selectable="" class="active-result group-option">' + make.charAt(0).toUpperCase() + make.substr(1)+ '</div>';
                return text;
            },
            item:function(data, escape) {
                return '<span class="tag label label-info">'+escape(data.name)+'</span>';
            }
        },
        persist: true,
        hideSelected: true,
        onChange: function(input) {
            "use strict";
            infoModels(input, yearSlide);
        },
        create: function(input) {
            return {
                name: input,
                id: input
            }
        }
    });
    $("#selected_models_trim").selectize({
        labelField: 'model_trim',
        valueField: 'id',
        maxItems: 1,
        sortField: "model_trim",
        persist: true,
        hideSelected: true,
        onChange: function(input) {
            "use strict";
            //infoModels(input, yearSlide);
        }
        /*render: {
            option:function(data, escape) {
                return '<div data-count="'+count_trim+'">'+escape(data.model_trim)+'</div>';
                count_trim++;
            }
        }*/
    });
});

function reloadModels(yearSlide){
    var make = $("#selected_make").val() == "" ? 0 : $("#selected_make").val(),
        year = yearSlide.slider('getValue'),
        selected_models = $(document).find("#selected_models"),
        _selected_models = selected_models[0].selectize;

    if(globalGetreloadModels != null)
        globalGetreloadModels.abort();

    globalGetreloadModels = $.get("/get/models/"+make+"/"+year+"/",function(data){
        _selected_models.clearOptions();
        _selected_models.load(function(callback) {callback(data)});
    })
}

function infoModels(id, yearSlide){
    "use strict";
    var type = "",
        selected_models_trim = $("#selected_models_trim")[0].selectize;
    if($.isNumeric(id))
        type = "id";
    else
        type = "name";

    $.get("/get/info/models/"+type+"/"+id+"/"+yearSlide.slider('getValue'),function(data){
        var trims = data.length;
        selected_models_trim.clearOptions();
        selected_models_trim.load(function(callback) {callback(data)});
    });

}