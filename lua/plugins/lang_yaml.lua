-- Cloudformation custom tags for yaml_ls
---@type LazySpec
return {
  {
    "AstroNvim/astrolsp",
    optional = true,
    ---@param opts AstroLSPOpts
    opts = {
      config = {
        yamlls = {
          settings = {
            yaml = {
              customTags = {
                "!And",
                "!And sequence",
                "!Base64",
                "!Cidr",
                "!Condition scalar",
                "!Equals",
                "!Equals sequence",
                "!FindInMap sequence",
                "!fn",
                "!GetAtt",
                "!GetAtt scalar",
                "!GetAZs",
                "!If",
                "!If sequence",
                "!ImportValue",
                "!ImportValue scalar",
                "!ImportValue sequence",
                "!Join sequence",
                "!Not",
                "!Not sequence",
                "!Or",
                "!Or sequence",
                "!Ref",
                "!Ref Scalar",
                "!Select",
                "!Split",
                "!Sub",
                "!Sub scalar",
                "!Sub sequence",
              },
            },
          },
        },
      },
    },
  },
}
