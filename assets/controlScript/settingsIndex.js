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
        $.get("/get/models/"+$("#selected_make").val()+"/"+yearSlide.slider('getValue')+"/",function(result){
            console.log(result);
        })
    }).on('slide', function(){
        $("#settings_year h6").text(yearSlide.slider('getValue'));
    });

    $('#selected_make, #selected_models').selectize({
        plugins: ['restore_on_backspace'],
        delimiter: ',',
        persist: false,
        sortField: "text",
        create: function(input) {
            return {
                value: input,
                text: input
            }
        },
        maxItems: 1,
        render: {
                option: function(data, escape) {
                    var make = escape(data.text);
                    var text = "";
                    if(firstLit != make[0]){
                        if(firstLit!=null) text += "</div>";
                        text += '<div data-value="" data-selectable="false" data-group="'+make[0]+'" class="optgroup">' +
                        '<div class="optgroup-header">'+make[0]+'</div>';
                        firstLit = make[0];
                    }
                    text += '<div data-value="' + make + '" data-selectable="" class="active-result group-option">' + make + '</div>';
                    return text;
                },
            item:function(data, escape) {
                return '<span class="tag label label-info">'+escape(data.text)+'</span>';
            }
        }
    });
/*
    var mySlider = new Slider(".slider", {
        // initial options object
        slide: function(){
            console.log($(this).getValue());
        },
        slideStop: function(){
            console.log($(this).getValue());
        }
    });*/
});