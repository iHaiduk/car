$(document).ready(function(){

    var vinSend = $("#vinSend");
    $("#vinId" ).on("keyup focusout",function(){
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
        var self = $(this);
        if(self.hasClass("has-success")){
            $.ajax({
                url: "/vin/get",
                type: "GET",
                data: {vin: self.val()},
                dataType: "json",
                success: function(data){
                    console.log(data)
                }
            });
        }
    });
});