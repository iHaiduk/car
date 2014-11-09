_Upload=
  uploadFile: (req, res)->
    res.setTimeout 0
    maxBytes = 6*1024*1024
    req.file("files").on("progress", (event) ->
      return event
    ).upload

    # You can apply a file upload limit (in bytes)
      dirname: "../../assets/upload"
      maxBytes: maxBytes
    , (err, uploadedFiles) ->
        return res.send(500, err)  if err
        _User.addFile uploadedFiles[0], req, (data) ->
          res.json
            message: true
            files: data

  upload: (req, res)->
    res.view("upload/index")

  delete: (req, res)->
    console.log req.query

  download: (req, res) ->
    require("fs").createReadStream(req.param("path")).on("error", (err) ->
      res.serverError err
    ).pipe res
    return


module.exports = _Upload