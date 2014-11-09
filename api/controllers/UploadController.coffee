_Upload=
  uploadFile: (req, res)->
    res.setTimeout 0
    maxBytes = 5*1024*1024 + 1
    if(req._fileparser.form.bytesExpected > maxBytes)
      return res.json
        message: false
        error: 0

    req.file("files").on("progress", (event) ->
      return event
    ).upload
    # You can apply a file upload limit (in bytes)
      dirname: "../../assets/upload"
      maxBytes: maxBytes
    , (err, uploadedFiles) ->
        return res.send(500, err)  if err

        file = uploadedFiles[0]
        textract = require 'mime'
        file.type = textract.lookup(file.fd)

        if file.type in ["image/jpeg", "image/gif", "image/png", "application/msword", "application/vnd.openxmlformats-officedocument.wordprocessingml.document", "plain/text", "text/plain"]
          _User.addFile file, req, (data) ->
            res.json
              message: true
              files: data
          return
         else
          return res.json
            message: false
            error: 1

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