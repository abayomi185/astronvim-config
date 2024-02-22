return {
  settings = {
    yaml = {
      hover = true,
      completion = true,
      validate = { enable = true },
      customTags = {
        "!Ref",
        "!GetAtt",
        "!FindInMap sequence",
        "!FindInMap scalar",
        "!GetAtt",
        "!GetAZs",
        "!Cidr",
        "!ImportValue",
        "!Join sequence",
        "!Select",
        "!Split",
        "!Sub sequence",
        "!Sub scalar",
        "!And",
        "!Equals",
        "!If",
        "!Not",
        "!Or",
      },
    },
  },
}
