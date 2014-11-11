@fl_count_load = 0
(($, window, document) ->
  $ ->
    progressbar = $("#progressbar")
    bar = progressbar.find(".progress-bar")
    select = new $.upload.select($("#upload-select"))
    drop = new $.upload.drop($("#upload-drop"))
    return

  return
) jQuery, window, document

(($, window, document) ->
  fl_k = 0
  fl_arrray = $(document).find "#files"
  xhrupload = (files, settings) ->
    upload = (files, settings) ->
      return false if @fl_count_load > 4
      # upload all at once
      formData = new FormData()
      xhr = new XMLHttpRequest()
      return  if settings.before(settings, files) is false
      i = 0
      f = undefined

      while f = files[i]
        formData.append settings.param, f
        i++
      for p of settings.params
        formData.append p, settings.params[p]

      # Add any event handlers here...
      xhr.upload.addEventListener "progress", ((e) ->
        percent = (e.loaded / e.total) * 100
        settings.progress percent, e
        return
      ), false
      xhr.addEventListener "loadstart", ((e) ->
        settings.loadstart e
        return
      ), false
      xhr.addEventListener "load", ((e) ->
        settings.load e
        return
      ), false
      xhr.addEventListener "loadend", ((e) ->
        settings.loadend e
        return
      ), false
      xhr.addEventListener "error", ((e) ->
        settings.error e
        return
      ), false
      xhr.addEventListener "abort", ((e) ->
        settings.abort e
        return
      ), false
      xhr.open settings.method, settings.action, true
      xhr.onreadystatechange = ->
        settings.readystatechange xhr
        if xhr.readyState is 4
          response = xhr.responseText
          if settings.type is "json"
            try
              response = $.parseJSON(response)
            catch e
              response = false
          settings.complete response, xhr
        return

      xhr.send formData
      return
    return this  unless $.support.ajaxupload
    settings = $.extend({}, xhrupload.defaults, settings)
    return  unless files.length
    if settings.allow isnt "*.*"
      i = 0
      file = undefined

      while file = files[i]
        if parseInt(file.size) > settings.maxsize
          settings.bigsize file
        unless matchName(settings.allow, file.name)
          if typeof (settings.notallowed) is "string"
            $.notify settings.notallowed,
              pos: "top-right"
          else
            settings.notallowed file, settings
          return
        i++
    complete = settings.complete
    if settings.single
      count = files.length
      uploaded = 0
      settings.complete = (response, xhr) ->
        uploaded = uploaded + 1
        complete response, xhr
        if uploaded < count
          upload [files[uploaded]], settings
        else
          settings.allcomplete response, xhr
        return

      upload [files[0]], settings
    else
      settings.complete = (response, xhr) ->
        complete response, xhr
        settings.allcomplete response, xhr
        return

      upload files, settings
    return

  # events

  # Upload Completed
  matchName = (pattern, path) ->
    parsedPattern = "^" + pattern.replace(/\//g, "\\/").replace(/\*\*/g, "(\\/[^\\/]+)*").replace(/\*/g, "[^\\/]+").replace(/((?!\\))\?/g, "$1.") + "$"
    parsedPattern = "^" + parsedPattern + "$"
    path.match(new RegExp(parsedPattern)) isnt null
  UploadSelect = (element, options) ->
    $this = this
    $element = $(element)
    options = $.extend({}, xhrupload.defaults, UploadSelect.defaults, options)
    return  if $element.data("uploadSelect")
    @element = $element.on("change", ->
      xhrupload $this.element[0].files, options
      return
    )
    $element.data "uploadSelect", this
    return

  UploadSelect.defaults = {}
  UploadDrop = (element, options) ->
    $this = this
    $element = $(element)
    options = $.extend({}, xhrupload.defaults, UploadDrop.defaults, options)
    hasdragCls = false
    return  if $element.data("uploadDrop")
    $element.on("drop", (e) ->
      if e.dataTransfer and e.dataTransfer.files
        e.stopPropagation()
        e.preventDefault()
        $element.removeClass options.dragoverClass
        xhrupload e.dataTransfer.files, options
      return
    ).on("dragenter", (e) ->
      e.stopPropagation()
      e.preventDefault()
      return
    ).on("dragover", (e) ->
      e.stopPropagation()
      e.preventDefault()
      unless hasdragCls
        $element.addClass options.dragoverClass
        hasdragCls = true
      return
    ).on "dragleave", (e) ->
      e.stopPropagation()
      e.preventDefault()
      $element.removeClass options.dragoverClass
      hasdragCls = false
      return

    $element.data "uploadDrop", this
    return

  UploadDrop.defaults = dragoverClass: "dragover"
  $.upload =
    select: UploadSelect
    drop: UploadDrop

  $.support.ajaxupload = (->
    supportFileAPI = ->
      fi = document.createElement("INPUT")
      fi.type = "file"
      "files" of fi
    supportAjaxUploadProgressEvents = ->
      xhr = new XMLHttpRequest()
      !!(xhr and ("upload" of xhr) and ("onprogress" of xhr.upload))
    supportFormData = ->
      !!window.FormData
    supportFileAPI() and supportAjaxUploadProgressEvents() and supportFormData()
  )()
  $.event.props.push "dataTransfer"  if $.support.ajaxupload
  xhrupload.defaults =
    action: "/upload/file"
    single: true
    method: "POST"
    param: "files"
    params: {}
    maxsize: 5*1024*1024
    allow: "*.(jpg|jpeg|gif|png|txt|doc|docx)"
    type: "text"
    before: (o, files) ->
      return if parseInt(files[0].size) > o.maxsize
      hideLoad @fl_count_load
      file = files[0]
      html = $('<div class="panel widget" id="temp_'+file.name.substr(0, 1)+'_'+parseInt(file.size)+'">
        <div class="row row-table row-flush">
            <div class="col-xs-2 bg-info text-center">
                <em class="fa fa-download fa-2x"></em>
            </div>
            <div class="col-xs-9">
                <div class="panel-body text-center">
                    <h4 class="mt0">'+file.name.substr(0, file.name.lastIndexOf('.'))+'</h4>
                    <small>
                        <em class="fa fa-inbox"></em>'+bytesToSize(parseInt(file.size))+'
                        <em class="fa fa-info"></em><span>'+file.type+'</span>
                    </small>
                </div>
                <div class="progress progress-striped progress-xs active">
                    <div role="progressbar" aria-valuenow="0" aria-valuemin="0" style="width: 0%" aria-valuemax="100" class="progress-bar progress-bar-info">
                    </div>
                </div>
            </div>
            <div class="col-xs-1 bg-inverse text-center delete_file">
                <em class="fa fa-minus"></em>
            </div>
        </div>
    </div>')
      fl_arrray.append(html)
      return

    load: ->

    loadend: ->

    error: ->

    abort: ->

    complete: (response, xhr) ->
      response = JSON.parse(response)
      th_fl = $(document).find("#temp_"+response.files.filename.substr(0, 1)+"_"+parseInt(response.files.size))
      th_fl.attr "data-id", response.files.id
      th_fl.find(".delete_file").attr "data-id", response.files.id
      if response.files.type in ["image/jpeg", "image/gif", "image/png"]
        th_fl.find(".fa-2x").removeClass("fa-upload").addClass "fa-picture-o"
      else if response.files.type in ["application/msword", "application/vnd.openxmlformats-officedocument.wordprocessingml.document"]
        th_fl.find(".fa-info").next().text("msword")
        th_fl.find(".fa-2x").removeClass("fa-upload").addClass "fa-file-text"
      else
        th_fl.find(".fa-info").next().text("text")
        th_fl.find(".fa-2x").removeClass("fa-upload").addClass "fa-list-alt"

      @fl_count_load++
      @hideLoad @fl_count_load
      return

    loadstart: (e) ->

    progress: (percent, e) ->
      file_l = fl_arrray.find(".panel")[fl_k]
      progress_b = $(file_l).find(".progress-bar")
      progress_b.attr("aria-valuenow", percent).css("width", percent+"%")
      if percent==100
        progress_b.parent().slideUp 500
        fl_k++
      return

    allcomplete: (response, xhr) ->

    readystatechange: ->

    bigsize: (file)->
      $.notify "Файл: "+file.name.substr(0, file.name.lastIndexOf('.'))+"<br> весит более 5MB",
        pos: "top-right"
    notallowed: (file)->
      $.notify "Файл: "+file.name.substr(0, file.name.lastIndexOf('.'))+"<br> имеет не поддерживаемый формат",
        pos: "top-right"


  $.xhrupload = xhrupload
  xhrupload
) jQuery, window, document

@hideLoad = (cnt_upl) ->
  upload_drp = $(document).find("#upload-drop")
  if cnt_upl > 4
    upload_drp.stop().slideUp 500
    return
  else
    upload_drp.stop().slideDown 500
    return

bytesToSize = (bytes) ->
  sizes = [
    "Bytes"
    "KB"
    "MB"
  ]
  return "0 Byte"  if bytes is 0
  i = parseInt(Math.floor(Math.log(bytes) / Math.log(1024)))
  Math.round(bytes / Math.pow(1024, i), 2) + " " + sizes[i]
