---@type LazySpec
return {
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    dependencies = {
      {
        "AstroNvim/astrolsp",
        optional = true,
        ---@type AstroLSPOpts
        opts = {
          ---@diagnostic disable: missing-fields
          config = {
            yamlls = {
              on_new_config = function(config)
                config.settings.yaml.schemas = vim.tbl_deep_extend(
                  "force",
                  config.settings.yaml.schemas or {},
                  require("schemastore").yaml.schemas()
                )
              end,
              settings = {
                yaml = {
                  schemaStore = { enable = false, url = "" },
                  schemas = {
                    kubernetes = {
                      "namespace.yaml",
                      "deployment.yaml",
                      "service.yaml",
                      "ingress.yaml",
                      "configmap.yaml",
                      "secret.yaml",
                      "persistentvolume.yaml",
                      "persistentvolumeclaim.yaml",
                      "statefulset.yaml",
                      "daemonset.yaml",
                      "job.yaml",
                      "cronjob.yaml",
                      "role.yaml",
                      "rolebinding.yaml",
                      "clusterrole.yaml",
                      "clusterrolebinding.yaml",
                      "serviceaccount.yaml",
                      "networkpolicy.yaml",
                    },
                  },
                },
              },
            },
          },
        },
      },
    },
  },
  {
    "AstroNvim/astrolsp",
    optional = true,
    ---@param opts AstroLSPOpts
    opts = {
      config = {
        yaml = {
          -- Cloudformation custom tags for yaml_ls
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
}
