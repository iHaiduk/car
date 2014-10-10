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
        $.get("/get/models/make/"+$("#make_select").val()+"/year/"+yearSlide.slider('getValue')+"/",function(result){
            console.log(result);
        })
    }).on('slide', function(){
        $("#settings_year h6").text(yearSlide.slider('getValue'));
    });

    $('#selected_make').selectize({
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
            render: {
                option: function(item, escape) {
                    return '<div>' +
                    '<span class="title">' +data.text +
                    '</span>' +
                    '</div>';
                }
            },
            item: function(data, escape) {
                console.log(escape(data.text), data)
                //if(firstLit != )
                //<div data-group="B" class="optgroup"><div class="optgroup-header">B</div><div data-value="84" data-selectable="" class="option">Beijing</div><div data-value="5" data-selectable="" class="option">Bentley</div><div data-value="120" data-selectable="" class="option">Bizzarrini</div><div data-value="4" data-selectable="" class="option">BMW</div><div data-value="135" data-selectable="" class="option">Brilliance</div><div data-value="83" data-selectable="" class="option">Bristol</div><div data-value="6" data-selectable="" class="option">Bugatti</div><div data-value="11" data-selectable="" class="option">Buick</div></div>
                return '<div>"' + escape(data.text) + '"</div>';
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