module.exports = main: (req, res) ->
  AutoParam.find({limit: 1000}).populate("model_id", {limit: 1000, sort: "name"}).exec (req, result) ->
    res.json(result)
  return