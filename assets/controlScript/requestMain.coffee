$(document).ready ->
  $.extend true, $.fn.dataTable.defaults,
    sDom: "<'row'<'col-xs-6'l><'col-xs-6'f>r>" + "t" + "<'row'<'col-xs-6'i><'col-xs-6'p>>"

  $("#stoList").dataTable
    paging: true
    ordering: true
    info: true
    bFilter: false
    oLanguage:
      sSearch: "Search all columns:"
      sLengthMenu: "_MENU_ records per page"
      info: "Showing page _PAGE_ of _PAGES_"
      zeroRecords: "Nothing found - sorry"
      infoEmpty: "No records available"
      infoFiltered: "(filtered from _MAX_ total records)"
  $("#requestList").dataTable
    paging: true
    ordering: true
    info: true
    bFilter: false
    "dom": 'rt<"bottom"flp><"clear">'
    oLanguage:
      sSearch: "Search all columns:"
      sLengthMenu: "_MENU_ records per page"
      info: "Showing page _PAGE_ of _PAGES_"
      zeroRecords: "Nothing found - sorry"
      infoEmpty: "No records available"
      infoFiltered: "(filtered from _MAX_ total records)"

  $select_state = $("#group_of_spare_parts, #type_of_spare_parts, #condition_parts, #delivery_time, #user_car").selectize()
  $("#part_number").numberMask beforePoint: 15
  reg = /^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/
  $("#link_item").on("keyup", ->
    switch
      when $(this).val() is "" then $(this).parent().removeClass("has-error has-success has-warning")
      when reg.test($(this).val()) then $(this).parent().removeClass("has-error has-warning").addClass("has-success")
      else $(this).parent().removeClass("has-success has-error").addClass("has-warning")
  ).on("focus focusout", ->
    switch
      when $(this).val() is "" then $(this).parent().removeClass("has-error has-success has-warning")
      when reg.test($(this).val()) then $(this).parent().removeClass("has-error has-warning").addClass("has-success")
      else $(this).parent().removeClass("has-success has-warning").addClass("has-error")
  )
  $(document).delegate ".delete_file", "click", ->
    _this = this
    $.get("/upload/delete",
      id: $(_this).data().id
    ).done (data) ->
      if data
        $(_this).parent().parent().slideUp 500, -> $(this).remove()
        fl_count_load--  if fl_count_load > 0
        hideLoad fl_count_load
        return

    return

  $(document).on "click", "#newRequest", ->
    data =
      user_car: $("#user_car").val()
      required_item: $("#required_item").val()
      part_number: $("#part_number").val()
      group_of_spare_parts: $("#group_of_spare_parts").val()
      type_of_spare_parts: $("#type_of_spare_parts").val()
      condition_parts: $("#condition_parts").val()
      delivery_time: $("#delivery_time").val()
      link_item: $("#link_item").val()
      _csrf: $("#_csrf").val()
      files: (->
        files = []
        $(document).find("#files .panel").each ->
          files.push $(this).data().id
          return
        files.join(",")
      )()
    if data.required_item is ""
      $.notify "Поле 'Требуемая деталь' не заполнено!",
        pos: "top-right"
    else
      $.post("/request/new",
        data
      ).done (data) ->
        console.log data


