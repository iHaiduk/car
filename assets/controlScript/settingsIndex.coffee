infoObject = {}

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

currentInfo = (id) ->
  for inf, val of infoObject
    if parseInt(id)is val.id
      val
    else
      continue

setInfo = (info) ->
  $("#model_transmission_type").val info.model_transmission_type
  $("#model_body").val info.model_body
  $("#region").val info.region
  $("#country").val info.country
  $("#model_drive").val info.model_drive
  $("#model_engine_type").val info.model_engine_type
  $("#model_engine_position").val info.model_engine_position
  $("#model_engine_cyl").val info.model_engine_cyl
  $("#model_engine_cc").val info.model_engine_cc
  $("#model_engine_valves_per_cyl").val info.model_engine_valves_per_cyl
  $("#model_engine_ci").val info.model_engine_ci
  $("#model_engine_torque_rpm").val info.model_engine_torque_rpm
  $("#model_engine_fuel").val info.model_engine_fuel
  $("#model_lkm_hwy").val info.model_lkm_hwy
  $("#model_lkm_city").val info.model_lkm_city
  $("#model_fuel_cap_l").val info.model_fuel_cap_l
  $("#model_length_mm").val info.model_length_mm
  $("#model_width_mm").val info.model_width_mm
  $("#model_height_mm").val info.model_height_mm
  $("#model_weight_kg").val info.model_weight_kg

infoModels = (id, yearSlide) ->
  "use strict"
  type = ""
  selected_models_trim = $("#selected_models_trim")[0].selectize
  if $.isNumeric(id)
    type = "id"
  else
    type = "name"
  $.get "/get/info/models/" + type + "/" + id + "/" + yearSlide.slider("getValue"), (data) ->
    lngth = data.length
    if lngth
      if lngth == 1
        setInfo data[0]
      infoObject = data
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
          vin: vinId.val()

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
      searchField: "name"
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
    searchField: "name"
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
    searchField: "model_trim"
    persist: true
    hideSelected: true
    onChange: (input) ->
      "use strict"
      info = currentInfo(input)[0]
      if info?
        setInfo info

      console.log $('#paramModelForm').serializeJSON();
      return

  $("#model_transmission_type, #model_body, #region, #country, #model_drive").selectize
    maxItems: 1
    valueField: "key"
    labelField: "title"
    searchField: "title"
    sortField: "title"
    create: false
    persist: true
    hideSelected: true
    create: (input) ->
      title: input
      key: input

  model_transmission_type_selectize = $("#model_transmission_type")[0].selectize;
  model_body_selectize = $("#model_body")[0].selectize;
  region_selectize = $("#region")[0].selectize;
  country_selectize = $("#country")[0].selectize;
  model_drive_selectize = $("#model_drive")[0].selectize;

  model_transmission_type_selectize.clear();
  model_body_selectize.clear();
  region_selectize.clear();
  country_selectize.clear();
  model_drive_selectize.clear();

  model_transmission_type_selectize.clearOptions();
  model_body_selectize.clearOptions();
  region_selectize.clearOptions();
  country_selectize.clearOptions();
  model_drive_selectize.clearOptions();

  model_transmission_type_selectize.load (callback) ->
    callback(kpp)
  model_body_selectize.load (callback) ->
    callback(model_body)
  region_selectize.load (callback) ->
    callback(region)
  country_selectize.load (callback) ->
    callback(country)
  model_drive_selectize.load (callback) ->
    callback(model_drive)


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

  socket = io.connect("http://localhost")
  socket.on "news", (data) ->
    console.log data
    socket.emit "my other event",
      my: "data"

  return
