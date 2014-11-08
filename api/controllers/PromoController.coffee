module.exports =

  promo: (req, res) ->
    res.view "promo/main",
      layout: "layout_promo"

  index: (req, res) ->
    res.view "homepage"