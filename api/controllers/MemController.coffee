module.exports = main: (req, res) ->
  mc = require("mc")
  client = new mc.Client([
    "127.0.0.1"
  ])
  client.connect ->
    console.log "Connected to memcache on four hosts all on port 11211!" ;