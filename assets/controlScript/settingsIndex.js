$(document).ready(function(){

    // Settings Page
    var vinSend = $("#vinSend"),
        vinId = $("#vinId"),
        yearSlide = $(".slider").slider();
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
        $.get("/get/models/make/"+$("#make_select").val()+"/year/"+yearSlide.slider('getValue')+"/",function(result){
            console.log(result);
        })
    }).on('slide', function(){
        $("#settings_year h6").text(yearSlide.slider('getValue'));
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