// Generated by CoffeeScript 1.8.0
(function() {
  var clearForm, currentInfo, globalGetreloadModels, infoModels, infoObject, interval_send_i, interval_send_info, interval_send_info_k, nospace, reloadModels, returnName, sendInfo, setInfo, vin_load;

  infoObject = {};

  interval_send_info = null;

  interval_send_info_k = 1;

  interval_send_i = true;

  vin_load = true;

  reloadModels = function(rCall) {
    var globalGetreloadModels, make, selected_models, year, _selected_models;
    make = ($("#selected_make").val() === "" ? 0 : $("#selected_make").val());
    year = $(document).find("#settings_year h6.text-center").text();
    selected_models = $(document).find("#selected_models");
    _selected_models = selected_models[0].selectize;
    clearForm();
    if (typeof globalGetreloadModels !== "undefined" && globalGetreloadModels !== null) {
      globalGetreloadModels.abort();
    }
    globalGetreloadModels = $.get("/get/models/" + make + "/" + year + "/", function(data) {
      _selected_models.clearOptions();
      _selected_models.load(function(callback) {
        callback(data);
        if (rCall && typeof rCall === "function") {
          rCall();
        }
      });
    });
  };

  nospace = function(str) {
    return str.replace(/\s+/g, '');
  };

  currentInfo = function(id) {
    var inf, val, _results;
    _results = [];
    for (inf in infoObject) {
      val = infoObject[inf];
      if (parseInt(id) === val.id) {
        _results.push(val);
      } else {
        continue;
      }
    }
    return _results;
  };

  clearForm = function() {
    return $("#paramModelForm").find("input").each(function() {
      if ($(this).hasClass("selectized")) {
        $(this)[0].selectize.setValue("");
      } else if ($(this).is(":checkbox")) {
        $(this).prop('checked', false);
      } else {
        $(this).val("");
      }
    });
  };

  sendInfo = function() {
    clearTimeout(interval_send_info);
    interval_send_info = null;
    interval_send_info = setTimeout(function() {
      var info_send, select_make, select_model, selected_models_trim, _m, _mk, _t;
      info_send = {};
      select_make = $(document).find("#selected_make")[0].selectize;
      select_model = $(document).find("#selected_models")[0].selectize;
      selected_models_trim = $(document).find("#selected_models_trim")[0].selectize;
      info_send["make_id"] = select_make.getValue();
      info_send["model_id"] = select_model.getValue();
      info_send["make_name"] = (_mk = select_make.sifter.items[info_send["make_id"]]) != null ? _mk.name : null;
      info_send["model_name"] = (_m = select_model.sifter.items[info_send["model_id"]]) != null ? _m.name : null;
      info_send["model_trim"] = (_t = selected_models_trim.sifter.items[selected_models_trim.getValue()]) != null ? _t.model_trim : null;
      $("#paramModelForm").find("input").each(function() {
        if ($(this).hasClass("selectized")) {
          info_send[$(this)[0].id] = $(this)[0].selectize.getValue();
        } else if ($(this).is(":checkbox")) {
          info_send[$(this)[0].id] = $(this).is(":checked") ? 1 : 0;
        } else {
          info_send[$(this)[0].id] = $(this).val();
        }
      });
      info_send._csrf = postCode;
      info_send[$("#region")[0].id] = $("#region")[0].selectize.getValue();
      $(document).find("#carspinner").css("opacity", 1);
      $.ajax({
        url: "/set/param",
        type: "POST",
        data: info_send,
        dataType: "json",
        success: function() {
          $(document).find("#carspinner").css("opacity", 0);
        }
      });
    }, 750);
  };

  setInfo = function(info, send) {
    var select_make, select_model;
    if (send == null) {
      send = true;
    }
    $.each(info, function(key, val) {
      var s, v;
      if ($("#" + key).hasClass("selectized")) {
        s = $("#" + key)[0].selectize.getValue();
        if (s === "") {
          $("#" + key)[0].selectize.setValue(val);
        }
      } else {
        v = $("#" + key).val();
        if (v === "") {
          $("#" + key).val(val);
        }
      }
    });
    info._csrf = postCode;
    $(document).find("#paramModelForm :checkbox").each(function() {
      info[$(this)[0].id] = $(this).is(":checked") ? 1 : 0;
    });
    select_make = $(document).find("#selected_make")[0].selectize;
    select_model = $(document).find("#selected_models")[0].selectize;
    info["make_name"] = select_make.sifter.items[select_make.getValue()].name;
    info["model_name"] = returnName(select_model.sifter.items[select_model.getValue()].name);
    info[$("#region")[0].id] = $("#region")[0].selectize.getValue();
    return sendInfo();
  };

  infoModels = function(id, yearSlide) {
    "use strict";
    var selected_models_trim, type, _s, _tr;
    type = "";
    _tr = $("#selected_models")[0].selectize;
    selected_models_trim = (_s = _tr.getValue()) !== "" ? _s : null;
    if ($.isNumeric(id)) {
      type = "id";
    } else {
      type = "name";
    }
    $.get("/get/info/models/" + type + "/" + selected_models_trim + "/" + yearSlide.slider("getValue"), function(data) {
      var lngth;
      lngth = data.length;
      if (lngth) {
        if (lngth === 1) {
          setInfo(data[0]);
        }
        infoObject = data;
        $(document).find("#selected_models_trim")[0].selectize.clearOptions();
        $(document).find("#selected_models_trim")[0].selectize.load(function(callback) {
          callback(data);
        });
      }
    });
  };

  returnName = function(text) {
    var m, p, re;
    re = "(.*?)(\\()";
    p = new RegExp(re);
    m = p.exec(text);
    if (m != null) {
      return $.trim(m[1]);
    } else {
      return null;
    }
  };

  globalGetreloadModels = null;

  $(document).ready(function() {
    var country_selectize, firstLit, info_car_input, make_select, model_body_selectize, model_drive_selectize, model_engine_fuel_selectize, model_engine_position_selectize, model_engine_type_selectize, model_transmission_type_selectize, region_selectize, vinId, vinSend, yearSlide;
    vinSend = $("#vinSend");
    vinId = $("#vinId");
    yearSlide = $(".slider").slider();
    make_select = $(".make_select");
    firstLit = null;
    info_car_input = $("#paramModelForm").find("input");
    info_car_input.on("click keyup focusout", function() {
      if (interval_send_i) {
        return sendInfo();
      }
    });
    vinId.on("keyup focusout", function() {
      var alNumRegex, text, _this;
      _this = $(this);
      text = nospace(_this.val());
      _this.val(text.slice(0, 18));
      alNumRegex = /^([a-zA-Z0-9]+)$/;
      $(this).parent().removeClass("has-success has-error");
      vinSend.removeClass("btn-danger btn-success").find("i").removeClass("fa-check fa-times");
      if (text.length === 17 && alNumRegex.test(text)) {
        $(this).parent().addClass("has-success");
        vinSend.addClass("btn-success").find("i").addClass("fa-check");
      } else {
        $(this).parent().addClass("has-error");
        vinSend.addClass("btn-danger").find("i").addClass("fa-times");
      }
    });
    $("#save").on("click", function() {
      interval_send_i = false;
      return sendInfo();
    });
    vinSend.on("click", function() {
      vin_load = false;
      if ($(this).hasClass("btn-success")) {
        $.ajax({
          url: "/get/vin",
          type: "GET",
          data: {
            vin: vinId.val()
          },
          dataType: "json",
          success: function(data) {
            var _selected_models;
            console.log(data);
            yearSlide.slider('setValue', parseInt(data.year));
            $(document).find("#settings_year h6.text-center").text(data.year);
            $(document).find("#selected_make")[0].selectize.setValue(data.make_id);
            _selected_models = $(document).find("#selected_models")[0].selectize;
            _selected_models.clearOptions();
            _selected_models.load(function(callback) {
              callback(data.models);
              return $(document).find("#selected_models")[0].selectize.setValue(data.model_id);
            });
            return vin_load = true;
          }
        });
      }
    });
    yearSlide.on("slideStop", function() {
      $("#settings_year h6").text(yearSlide.slider("getValue"));
      reloadModels();
    }).on("slide", function() {
      $("#settings_year h6").text(yearSlide.slider("getValue"));
    });
    $.get("/get/makes/", function(data) {
      $("#selected_make").selectize({
        options: data,
        labelField: "name",
        valueField: "id",
        maxItems: 1,
        sortField: "name",
        searchField: "name",
        persist: false,
        create: function(input) {
          return {
            name: input,
            id: input
          };
        },
        onChange: function() {
          clearForm();
          if (vin_load) {
            reloadModels();
          }
        },
        onOptionAdd: function() {
          clearForm();
          sendInfo();
        },
        render: {
          option: function(data, escape) {
            var make, text;
            make = escape(data.name);
            text = "";
            if (firstLit !== make[0].toUpperCase()) {
              if (firstLit != null) {
                text += "</div>";
              }
              text += "<div data-value=\"\" data-selectable=\"false\" data-group=\"" + make[0] + "\" class=\"optgroup\">" + "<div class=\"optgroup-header\">" + make[0] + "</div>";
              firstLit = make[0].toUpperCase();
            }
            text += "<div data-value=\"" + escape(data.id) + "\" data-selectable=\"\" class=\"active-result group-option\">" + make.charAt(0).toUpperCase() + make.substr(1) + "</div>";
            return text;
          },
          item: function(data, escape) {
            return "<span class=\"tag label label-info\">" + escape(data.name) + "</span>";
          }
        }
      });
    });
    $("#selected_models").selectize({
      labelField: "name",
      valueField: "id",
      maxItems: 1,
      sortField: "name",
      searchField: "name",
      render: {
        option: function(data, escape) {
          var make, text;
          make = escape(data.name);
          text = "<div data-value=\"" + escape(data.id) + "\" data-selectable=\"\" class=\"active-result group-option\">" + make.charAt(0).toUpperCase() + make.substr(1) + "</div>";
          return text;
        },
        item: function(data, escape) {
          return "<span class=\"tag label label-info\">" + escape(data.name) + "</span>";
        }
      },
      persist: true,
      hideSelected: true,
      onChange: function(input) {
        "use strict";
        var m, name, p, year, _year;
        clearForm();
        _year = $(document).find("#settings_year h6.text-center");
        name = this.sifter.items[input] != null ? this.sifter.items[input].name : null;
        if (name != null) {
          p = new RegExp(".*?(\\()(\\d+)", ["i"]);
          m = p.exec(name);
          if (m != null) {
            year = m[2];
          } else {
            name = null;
          }
        }
        if ((name != null) && new RegExp("(\\d+)", ["i"]).test(year)) {
          _year.text(year);
          yearSlide.slider('setValue', parseInt(year));
          infoModels(input, yearSlide);
        } else {
          infoModels(input, yearSlide);
        }
      },
      create: function(input) {
        return {
          name: input,
          id: input
        };
      },
      onOptionAdd: function() {
        clearForm();
        sendInfo();
      }
    });
    $("#selected_models_trim").selectize({
      labelField: "model_trim",
      valueField: "id",
      maxItems: 1,
      sortField: "model_trim",
      searchField: "model_trim",
      persist: true,
      hideSelected: true,
      onChange: function(input) {
        var info;
        info = currentInfo(input)[0];
        if (info != null) {
          clearForm();
          setInfo(info);
        }
      },
      onOptionAdd: function() {
        clearForm();
        sendInfo();
      },
      create: function(input) {
        return {
          model_trim: input,
          id: input
        };
      }
    });
    $("#model_transmission_type, #model_body, #region, #country, #model_drive, #model_engine_type, #model_engine_position, #model_engine_fuel").selectize({
      maxItems: 1,
      valueField: "key",
      labelField: "title",
      searchField: "title",
      sortField: "title",
      create: false,
      persist: true,
      hideSelected: true,
      create: function(input) {
        return {
          title: input,
          key: input
        };
      },
      onChange: function() {
        if (interval_send_i) {
          return sendInfo();
        }
      }
    });
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
    model_transmission_type_selectize.load(function(callback) {
      return callback(kpp);
    });
    model_body_selectize.load(function(callback) {
      return callback(model_body);
    });
    region_selectize.load(function(callback) {
      return callback(region);
    });
    country_selectize.load(function(callback) {
      return callback(country);
    });
    model_drive_selectize.load(function(callback) {
      return callback(model_drive);
    });
    model_engine_type_selectize.load(function(callback) {
      return callback(model_engine_type);
    });
    model_engine_position_selectize.load(function(callback) {
      return callback(model_engine_position);
    });
    model_engine_fuel_selectize.load(function(callback) {
      return callback(model_engine_fuel);
    });
    $("#model_lkm_hwy, #model_lkm_city, #model_fuel_cap_l").numberMask({
      decimalMark: [".", ","],
      type: "float"
    });
    $("#model_engine_cc, #model_engine_ci, #model_engine_torque_rpm, #model_engine_cyl, #model_length_mm, #model_width_mm, #model_height_mm, #model_weight_kg, #model_engine_valves_per_cyl").numberMask({
      beforePoint: 5
    });
    $("#profileForm").bootstrapValidator({
      feedbackIcons: {
        valid: "glyphicon glyphicon-ok",
        invalid: "glyphicon glyphicon-remove",
        validating: "glyphicon glyphicon-refresh"
      },
      fields: {
        email: {
          validators: {
            notEmpty: {
              message: "The email address is required"
            },
            emailAddress: {
              message: "The email address is not valid"
            }
          }
        },
        password: {
          validators: {
            notEmpty: {
              message: "The password is required"
            }
          }
        }
      }
    });
  });

}).call(this);
