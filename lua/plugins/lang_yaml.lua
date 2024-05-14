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
                "!fn",
                "!And",
                "!If",
                "!Not",
                "!Equals",
                "!Or",
                "!FindInMap sequence",
                "!Base64",
                "!Cidr",
                "!Ref",
                "!Ref Scalar",
                "!Sub",
                "!GetAtt",
                "!GetAZs",
                "!ImportValue",
                "!Select",
                "!Split",
                "!Join sequence",
              },
            },
          },
        },
      },
    },
  },
}
