class _objOption
  keyed: (obj) ->
    ages = for key, value of obj
      {key: key, title: value}

module.exports = new _objOption