$("#stoList").dataTable
  paging: true # Table pagination
  ordering: true # Column ordering
  info: true # Bottom left status text
# Text translation options
# Note the required keywords between underscores (e.g _MENU_)
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
