---@type LazySpec
return {
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {},
    event = "BufRead package.json",
    enabled = false,
  },
  {
    "dmmulroy/tsc.nvim",
    cmd = "TSC",
    opts = {},
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      autocmds = {
        -- eslint_fix_on_save = {
        --   cond = function(client) return client.name == "eslint" and vim.fn.exists ":EslintFixAll" > 0 end,
        --   {
        --     event = "BufWritePost",
        --     desc = "Fix all eslint errors",
        --     callback = function() vim.cmd.EslintFixAll() end,
        --   },
        -- },
      },
      ---@diagnostic disable: missing-fields
      config = {
        vtsls = {
          settings = {
            typescript = {
              updateImportsOnFileMove = { enabled = "always" },
              inlayHints = {
                parameterNames = { enabled = "all" },
                parameterTypes = { enabled = true },
                variableTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
              },
            },
            javascript = {
              updateImportsOnFileMove = { enabled = "always" },
              inlayHints = {
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                variableTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
              },
            },
            vtsls = {
              enableMoveToFileCodeAction = true,
            },
          },
        },
      },
    },
  },
  {
    "yioneko/nvim-vtsls",
    lazy = true,
    dependencies = {
      "AstroNvim/astrocore",
      opts = {
        autocmds = {
          nvim_vtsls = {
            {
              event = "LspAttach",
              desc = "Load nvim-vtsls with vtsls",
              callback = function(args)
                if assert(vim.lsp.get_client_by_id(args.data.client_id)).name == "vtsls" then
                  require("vtsls")._on_attach(args.data.client_id, args.buf)
                  vim.api.nvim_del_augroup_by_name "nvim_vtsls"
                end
              end,
            },
          },
        },
      },
    },
    config = function(_, opts) require("vtsls").config(opts) end,
  },
  -- {
  --   "pmizio/typescript-tools.nvim",
  --   enabled = false,
  --   dependencies = {
  --     ---@type AstroLSPOpts
  --     "AstroNvim/astrolsp",
  --     optional = true,
  --     ---@diagnostic disable: missing-fields
  --     opts = {
  --       autocmds = {
  --         eslint_fix_on_save = {
  --           cond = function(client) return client.name == "eslint" and vim.fn.exists ":EslintFixAll" > 0 end,
  --           {
  --             event = "BufWritePost",
  --             desc = "Fix all eslint errors",
  --             callback = function() vim.cmd.EslintFixAll() end,
  --           },
  --         },
  --       },
  --       handlers = { tsserver = false, ts_ls = false }, -- disable tsserver setup, this plugin does it
  --       config = {
  --         ["typescript-tools"] = { -- enable inlay hints by default for `typescript-tools`
  --           settings = {
  --             tsserver_file_preferences = {
  --               includeInlayParameterNameHints = "all",
  --               includeInlayParameterNameHintsWhenArgumentMatchesName = false,
  --               includeInlayFunctionParameterTypeHints = true,
  --               includeInlayVariableTypeHints = true,
  --               includeInlayVariableTypeHintsWhenTypeMatchesName = false,
  --               includeInlayPropertyDeclarationTypeHints = true,
  --               includeInlayFunctionLikeReturnTypeHints = true,
  --               includeInlayEnumMemberValueHints = true,
  --             },
  --             expose_as_code_action = {
  --               -- "fix_all",
  --               "add_missing_imports",
  --               "remove_unused",
  --               "remove_unused_imports",
  --               "organize_imports",
  --             },
  --             tsserver_max_memory = 3072,
  --           },
  --         },
  --       },
  --     },
  --   },
  --   ft = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  --   -- get AstroLSP provided options like `on_attach` and `capabilities`
  --   opts = function(_, opts)
  --     local astrolsp_avail, astrolsp = pcall(require, "astrolsp")
  --     -- -- New
  --     -- opts.server = astrolsp_avail and astrolsp.lsp_opts "typescript-tools"
  --     -- opts.server.root_dir = require("lspconfig.util").root_pattern ".git"
  --     -- return opts
  --     -- Old
  --     if astrolsp_avail then return astrolsp.lsp_opts "typescript-tools" end
  --   end,
  -- },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    config = function()
      local dap = require "dap"
      if not dap.adapters["pwa-node"] then
        dap.adapters["pwa-node"] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "node",
            args = {
              require("mason-registry").get_package("js-debug-adapter"):get_install_path()
                .. "/js-debug/src/dapDebugServer.js",
              "${port}",
            },
          },
        }
      end
      if not dap.adapters.node then
        dap.adapters.node = function(cb, config)
          if config.type == "node" then config.type = "pwa-node" end
          local pwa_adapter = dap.adapters["pwa-node"]
          if type(pwa_adapter) == "function" then
            pwa_adapter(cb, config)
          else
            cb(pwa_adapter)
          end
        end
      end

      local js_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }
      local js_config = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file (Typescript)",
          cwd = "${workspaceFolder}",
          runtimeArgs = { "--loader=ts-node/esm" },
          program = "${file}",
          runtimeExecutable = "node",
          sourceMaps = true,
          protocol = "inspector",
          outFiles = { "${workspaceFolder}/**/**/*", "!**/node_modules/**" },
          skipFiles = { "<node_internals>/**", "node_modules/**" },
          resolveSourceMapLocations = {
            "${workspaceFolder}/**",
            "!**/node_modules/**",
          },
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          protocol = "inspector",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
      }

      for _, language in ipairs(js_filetypes) do
        if not dap.configurations[language] then dap.configurations[language] = js_config end
      end

      local vscode_filetypes = require("dap.ext.vscode").type_to_filetypes
      vscode_filetypes["node"] = js_filetypes
      vscode_filetypes["pwa-node"] = js_filetypes
    end,
  },
}
