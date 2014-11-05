_Upload=
  uploadFile: (req, res)->
    res.setTimeout 0
    maxBytes = 50*1024*1024
    req.file("files[]").on("progress", (event) ->
      console.log event.written+" / "+event.stream.byteCount
      return event
    ).upload

    # You can apply a file upload limit (in bytes)
      dirname: "../../assets/upload"
      maxBytes: maxBytes
    , (err, uploadedFiles) ->
        return res.send(500, err)  if err
        res.json
          message: uploadedFiles.length + " file(s) uploaded successfully!"
          files: uploadedFiles


  upload: (req, res)->
    res.view("upload/index")

  download: (req, res) ->
    require("fs").createReadStream(req.param("path")).on("error", (err) ->
      res.serverError err
    ).pipe res
    return


module.exports = _Upload