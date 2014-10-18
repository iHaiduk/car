reloadModels = (yearSlide) ->
  make = (if $("#selected_make").val() is "" then 0 else $("#selected_make").val())
  year = yearSlide.slider("getValue")
  selected_models = $(document).find("#selected_models")
  _selected_models = selected_models[0].selectize
  globalGetreloadModels.abort()  if globalGetreloadModels?
  globalGetreloadModels = $.get("/get/models/" + make + "/" + year + "/", (data) ->
    _selected_models.clearOptions()
    _selected_models.load (callback) ->
      callback data
      return

    return
  )
  return

nospace = (str) ->
  str.replace(/\s+/g,'');

infoModels = (id, yearSlide) ->
  "use strict"
  type = ""
  selected_models_trim = $("#selected_models_trim")[0].selectize
  if $.isNumeric(id)
    type = "id"
  else
    type = "name"
  $.get "/get/info/models/" + type + "/" + id + "/" + yearSlide.slider("getValue"), (data) ->
    trims = data.length
    selected_models_trim.clearOptions()
    selected_models_trim.load (callback) ->
      callback data
      return

    return

  return
globalGetreloadModels = null
$(document).ready ->
  vinSend = $("#vinSend")
  vinId = $("#vinId")
  yearSlide = $(".slider").slider()
  make_select = $(".make_select")
  firstLit = null
  vinId.on "keyup focusout", ->
    _this = $(this)
    text = nospace _this.val()

    console.log text

    _this.val text[0..17]
    alNumRegex = /^([a-zA-Z0-9]+)$/
    $(this).parent().removeClass "has-success has-error"
    vinSend.removeClass("btn-danger btn-success").find("i").removeClass "fa-check fa-times"
    if text.length is 17 and alNumRegex.test(text)
      $(this).parent().addClass "has-success"
      vinSend.addClass("btn-success").find("i").addClass "fa-check"
    else
      $(this).parent().addClass "has-error"
      vinSend.addClass("btn-danger").find("i").addClass "fa-times"
    return

  vinSend.on "click", ->
    if $(this).hasClass("btn-success")
      $.ajax
        url: "/get/vin"
        type: "GET"
        data:
          vin: $(this).val()

        dataType: "json"
        success: (data) ->
          console.log data




  yearSlide.on("slideStop", ->
    $("#settings_year h6").text yearSlide.slider("getValue")
    reloadModels yearSlide
    return
  ).on "slide", ->
    $("#settings_year h6").text yearSlide.slider("getValue")
    return

  $.get "/get/makes/", (data) ->
    $("#selected_make").selectize
      options: data
      labelField: "name"
      valueField: "id"
      maxItems: 1
      sortField: "name"
      persist: false
      create: (input) ->
        name: input
        id: input

      onChange: ->
        reloadModels yearSlide
        return

      render:
        option: (data, escape) ->
          make = escape(data.name)
          text = ""
          unless firstLit is make[0].toUpperCase()
            text += "</div>"  if firstLit?
            text += "<div data-value=\"\" data-selectable=\"false\" data-group=\"" + make[0] + "\" class=\"optgroup\">" + "<div class=\"optgroup-header\">" + make[0] + "</div>"
            firstLit = make[0].toUpperCase()
          text += "<div data-value=\"" + escape(data.id) + "\" data-selectable=\"\" class=\"active-result group-option\">" + make.charAt(0).toUpperCase() + make.substr(1) + "</div>"
          text

        item: (data, escape) ->
          "<span class=\"tag label label-info\">" + escape(data.name) + "</span>"

    return

  $("#selected_models").selectize
    labelField: "name"
    valueField: "id"
    maxItems: 1
    sortField: "name"
    render:
      option: (data, escape) ->
        make = escape(data.name)
        text = "<div data-value=\"" + escape(data.id) + "\" data-selectable=\"\" class=\"active-result group-option\">" + make.charAt(0).toUpperCase() + make.substr(1) + "</div>"
        text

      item: (data, escape) ->
        "<span class=\"tag label label-info\">" + escape(data.name) + "</span>"

    persist: true
    hideSelected: true
    onChange: (input) ->
      "use strict"
      infoModels input, yearSlide
      return

    create: (input) ->
      name: input
      id: input

  $("#selected_models_trim").selectize
    labelField: "model_trim"
    valueField: "id"
    maxItems: 1
    sortField: "model_trim"
    persist: true
    hideSelected: true
    onChange: (input) ->
      "use strict"
      return

  $("#profileForm").bootstrapValidator
    feedbackIcons:
      valid: "glyphicon glyphicon-ok"
      invalid: "glyphicon glyphicon-remove"
      validating: "glyphicon glyphicon-refresh"

    fields:
      email:
        validators:
          notEmpty:
            message: "The email address is required"

          emailAddress:
            message: "The email address is not valid"

      password:
        validators:
          notEmpty:
            message: "The password is required"


  return
