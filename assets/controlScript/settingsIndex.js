$(document).ready(function(){

    // Settings Page
    var vinSend = $("#vinSend");
    var vinId = $("#vinId");
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
    $('#input-tags').selectize({
        delimiter: ',',
        persist: false,
        create: function(input) {
            return {
                value: input,
                text: input
            }
        }
    });
    /*$('.slider').slider({
        min: 1940,
        max: 2015
    });*/
});