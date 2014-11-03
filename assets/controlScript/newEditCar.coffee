infoObject = {}
interval_send_info = null
interval_send_info_k = 1
interval_send_i = true
vin_load = true

reloadModels = (rCall) ->
  make = (if $("#selected_make").val() is "" then 0 else $("#selected_make").val())
  year = $(document).find("#settings_year h6.text-center").text() #yearSlide.slider("getValue")
  selected_models = $(document).find("#selected_models")
  _selected_models = selected_models[0].selectize
  clearForm()
  globalGetreloadModels.abort()  if globalGetreloadModels?
  globalGetreloadModels = $.get("/get/models/" + make + "/" + year + "/", (data) ->
    _selected_models.clearOptions()
    _selected_models.load (callback) ->
      callback data
      rCall()  if rCall and typeof (rCall) is "function"
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
clearForm = () ->
  $("#paramModelForm").find("input").each ->
    if $(this).hasClass "selectized"
      $(this)[0].selectize.setValue ""
      return
    else if $(this).is ":checkbox"
      $(this).prop 'checked', false
      return
    else
      $(this).val ""
      return

sendInfo = (end = false)->
  clearTimeout interval_send_info
  interval_send_info = null
  interval_send_info = setTimeout ->
    info_send = {}
    differences = {}
    select_make = $(document).find("#selected_make")[0].selectize
    select_model = $(document).find("#selected_models")[0].selectize
    selected_models_trim = $(document).find("#selected_models_trim")[0].selectize
    info_send["make_id"] = select_make.getValue()
    info_send["model_id"] = select_model.getValue()
    info_send["model_year"] = parseInt($(document).find("#settings_year h6.text-center").text())
    info_send["make_name"] = if (_mk = select_make.sifter.items[info_send["make_id"]])? then _mk.name else null
    info_send["model_name"] = if (_m = select_model.sifter.items[info_send["model_id"]])? then _m.name else null
    info_send["model_trim"] = if (_t = selected_models_trim.sifter.items[selected_models_trim.getValue()])? then _t.model_trim else null
    info_send["save"] = if end then 1 else 0
    $("#paramModelForm").find("input").each ->
      if $(this).hasClass "selectized"
        info_send[$(this)[0].id] = $(this)[0].selectize.getValue()
        return
      else if $(this).is ":checkbox"
        info_send[$(this)[0].id] = if $(this).is(":checked") then 1 else 0
        return
      else
        info_send[$(this)[0].id] = $(this).val()
        return
    info_send._csrf = postCode
    info_send[$("#region")[0].id] = $("#region")[0].selectize.getValue()
    $(document).find("#differences input").each ->
      differences[this.id] = if $(this).is(":checked") then 1 else 0
      return
    info_send["сhoice_differences"] = JSON.stringify(differences);
    info_send["text_differences"] = $("#differences textarea").data("markdownarea").preview.html();

    if _save is 0
      $(document).find("#carspinner").css "opacity", 1
      $.ajax
        url:"/set/param",
        type: "POST",
        data: info_send,
        dataType: "json",
        success: () ->
          if end
            $.notify("Параметры сохранено! Страница будет перезагружена через 5 секунд...", {pos:'top-right'})
            setTimeout ->
              window.location.reload()
            , 5000
          $(document).find("#carspinner").css "opacity", 0
          return
    return
  , 750
  return

setInfo = (info, send = true) ->
  $.each info, (key, val) ->
    if $("#"+key).hasClass "selectized"
      s = $("#"+key)[0].selectize.getValue()
      if s == ""
        $("#"+key)[0].selectize.setValue val
    else
      v = $("#"+key).val()
      if v == ""
        $("#"+key).val val
    return
  info._csrf = postCode
  $(document).find("#paramModelForm :checkbox").each ->
    info[$(this)[0].id] = if $(this).is(":checked") then 1 else 0
    return
  select_make = $(document).find("#selected_make")[0].selectize
  select_model = $(document).find("#selected_models")[0].selectize
  info["make_name"] = select_make.sifter.items[select_make.getValue()].name
  info["model_name"] = returnName select_model.sifter.items[select_model.getValue()].name
  info[$("#region")[0].id] = $("#region")[0].selectize.getValue()
  sendInfo()

infoModels = (id, yearSlide) ->
  type = ""
  _tr = $("#selected_models")[0].selectize
  selected_models_trim = if (_s = _tr.getValue()) != "" then _s else null
  if $.isNumeric(id)
    type = "id"
  else
    type = "name"
  $.get "/get/info/models/" + type + "/" + selected_models_trim + "/" + yearSlide.slider("getValue"), (data) ->
    lngth = data.length
    if lngth
      if lngth == 1
        setInfo data[0]
      infoObject = data
      $(document).find("#selected_models_trim")[0].selectize.clearOptions()
      $(document).find("#selected_models_trim")[0].selectize.load (callback) ->
        callback data
        return

    return

  return
returnName = (text) ->
  re = "(.*?)(\\()"
  p = new RegExp re
  m = p.exec(text)
  if m? then $.trim m[1] else null

globalGetreloadModels = null
$(document).ready ->
  vinSend = $("#vinSend")
  vinId = $("#vinCode")
  yearSlide = $(".slider").slider()
  make_select = $(".make_select")
  firstLit = null
  info_car_input = $("#paramModelForm").find "input"

  info_car_input.on "click keyup focusout", ->
    if interval_send_i
      sendInfo()

  vinId.on "keyup focusout", ->
    _this = $(this)
    text = nospace _this.val()
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

  $("#save").on "click", ->
    interval_send_i = false
    sendInfo(true)

  vinSend.on "click", ->
    vin_load = false
    if $(this).hasClass("btn-success")
      $.ajax
        url: "/get/vin"
        type: "GET"
        data:
          vin: vinId.val()
        dataType: "json"
        success: (data) ->
          yearSlide.slider 'setValue', parseInt data.year
          $(document).find("#settings_year h6.text-center").text(data.year)
          $(document).find("#selected_make")[0].selectize.setValue(data.make_id);
          _selected_models = $(document).find("#selected_models")[0].selectize
          _selected_models.clearOptions()
          _selected_models.load (callback) ->
            callback data.models
            $(document).find("#selected_models")[0].selectize.setValue(data.model_id);
          vin_load = true
      return
  yearSlide.on("slideStop", ->
    $("#settings_year h6").text yearSlide.slider("getValue")
    reloadModels()
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
        clearForm()
        reloadModels() if vin_load
        return
      onOptionAdd: ->
        clearForm()
        sendInfo()
        return

      onInitialize: ->
        this.setValue usr_car_param.make_id if usr_car_param.make_id?

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
        make = escape data.name
        text = "<div data-value=\"" + escape(data.id) + "\" data-selectable=\"\" class=\"active-result group-option\">" + make.charAt(0).toUpperCase() + make.substr(1) + "</div>"
        text

      item: (data, escape) ->
        "<span class=\"tag label label-info\">" + escape(data.name) + "</span>"

    persist: true
    hideSelected: true
    onInitialize: ->
      this.setValue usr_car_param.model_id if usr_car_param.model_id?
    onChange: (input) ->
      "use strict"
      clearForm()
      _year = $(document).find "#settings_year h6.text-center"
      name = if this.sifter.items[input]? then this.sifter.items[input].name else null
      if name?
        p = new RegExp ".*?(\\()(\\d+)", ["i"]
        m = p.exec name
        if m?
          year = m[2]
        else
          name = null

      if name? and new RegExp("(\\d+)", ["i"]).test year
        _year.text year
        yearSlide.slider 'setValue', parseInt year
        infoModels input, yearSlide
      else
        infoModels input, yearSlide
      return
    create: (input) ->
      name: input
      id: input
    onOptionAdd: ->
      clearForm()
      sendInfo()
      return

  $("#selected_models_trim").selectize
    labelField: "model_trim"
    valueField: "id"
    maxItems: 1
    sortField: "model_trim"
    searchField: "model_trim"
    persist: true
    hideSelected: true
    onChange: (input) ->
      info = currentInfo(input)[0]
      if info?
        clearForm()
        setInfo info
      return
    onOptionAdd: ->
      clearForm()
      sendInfo()
      return
    create: (input) ->
      model_trim: input
      id: input

  $("#model_transmission_type, #model_body, #region, #country, #model_drive, #model_engine_type, #model_engine_position, #model_engine_fuel").selectize
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
    onChange: ->
      if interval_send_i
        sendInfo()

  model_transmission_type_selectize = $("#model_transmission_type")[0].selectize;
  model_body_selectize = $("#model_body")[0].selectize;
  region_selectize = $("#region")[0].selectize;
  country_selectize = $("#country")[0].selectize;
  model_drive_selectize = $("#model_drive")[0].selectize;
  model_engine_type_selectize = $("#model_engine_type")[0].selectize;
  model_engine_position_selectize = $("#model_engine_position")[0].selectize;
  model_engine_fuel_selectize = $("#model_engine_fuel")[0].selectize;

  model_transmission_type_selectize.clear();
  model_body_selectize.clear();
  region_selectize.clear();
  country_selectize.clear();
  model_drive_selectize.clear();
  model_engine_type_selectize.clear();
  model_engine_position_selectize.clear();
  model_engine_fuel_selectize.clear();

  model_transmission_type_selectize.clearOptions();
  model_body_selectize.clearOptions();
  region_selectize.clearOptions();
  country_selectize.clearOptions();
  model_drive_selectize.clearOptions();
  model_engine_type_selectize.clearOptions();
  model_engine_position_selectize.clearOptions();
  model_engine_fuel_selectize.clearOptions();

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
  model_engine_type_selectize.load (callback) ->
    callback(model_engine_type)
  model_engine_position_selectize.load (callback) ->
    callback(model_engine_position)
  model_engine_fuel_selectize.load (callback) ->
    callback(model_engine_fuel)


  $("#model_lkm_hwy, #model_lkm_city, #model_fuel_cap_l").numberMask
    decimalMark: [
      "."
      ","
    ]
    type: "float"

  $("#model_engine_cc, #model_engine_ci, #model_engine_torque_rpm, #model_engine_cyl, #model_length_mm, #model_width_mm, #model_height_mm, #model_weight_kg, #model_engine_valves_per_cyl").numberMask beforePoint: 5

  yearSlide.slider 'setValue', parseInt usr_car_param.model_year
  $("#settings_year h6.text-center").text(usr_car_param.model_year)
  $.each usr_car_param, (key,val) ->
    return if key in ["make_id", "model_id", "model_year", "model_name", "make_name", "model_trim"]
    _this = $(document).find "#"+ key
    if _this.hasClass "selectized"
      _this[0].selectize.setValue val
      return
    else if _this.is ":checkbox"
      _this.prop "checked", val
      return
    else
      _this.val val
      return

