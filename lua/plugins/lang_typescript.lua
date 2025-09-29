local conform_formatter = function(_) return { "prettierd" } or {} end

local format_filetypes = {
  "css",
  "javascript",
  "javascriptreact",
  "json",
  "jsonc",
  "markdown",
  "mdx",
  "svelte",
  "typescript",
  "typescriptreact",
  "vue",
  "yaml",
}

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
    "echasnovski/mini.icons",
    optional = true,
    opts = {
      file = {
        [".eslintrc.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
        [".node-version"] = { glyph = "", hl = "MiniIconsGreen" },
        [".prettierrc"] = { glyph = "", hl = "MiniIconsPurple" },
        [".yarnrc.yml"] = { glyph = "", hl = "MiniIconsBlue" },
        ["eslint.config.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
        ["package.json"] = { glyph = "", hl = "MiniIconsGreen" },
        ["tsconfig.json"] = { glyph = "", hl = "MiniIconsAzure" },
        ["tsconfig.build.json"] = { glyph = "", hl = "MiniIconsAzure" },
        ["yarn.lock"] = { glyph = "", hl = "MiniIconsBlue" },
      },
    },
  },
  {
    "AstroNvim/astrolsp",
    opts = function(_, opts)
      ---@type AstroLSPOpts
      local ts_opts = {
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
            root_dir = require("lspconfig.util").root_pattern ".git",
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
                autoUseWorkspaceTsdk = true,
              },
            },
          },
        },
      }
      return require("astrocore").extend_tbl(opts, ts_opts)
    end,
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
  {
    "mfussenegger/nvim-dap",
    optional = true,
    config = function()
      local dap = require "dap"
      local outPath = vim.fn.trim(vim.fn.system "nix eval nixpkgs#vscode-js-debug.outPath --raw")
      if not dap.adapters["pwa-node"] then
        dap.adapters["pwa-node"] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "node",
            args = {
              outPath .. "/lib/node_modules/js-debug/dist/src/dapDebugServer.js",
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
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      if not opts.formatters_by_ft then opts.formatters_by_ft = {} end
      for _, filetype in ipairs(format_filetypes) do
        opts.formatters_by_ft[filetype] = conform_formatter
      end
    end,
  },
}
