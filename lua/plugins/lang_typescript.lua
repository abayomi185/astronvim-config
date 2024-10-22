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
    optional = true,
    opts = {
      config = {
        denols = {
          -- adjust deno ls root directory detection
          root_dir = function(...)
            return require("lspconfig.util").root_pattern("deno.json", "deno.jsonc", "deno.lock")(...)
          end,
        },
      },
    },
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = {
      ---@type AstroLSPOpts
      "AstroNvim/astrolsp",
      optional = true,
      ---@diagnostic disable: missing-fields
      opts = {
        autocmds = {
          eslint_fix_on_save = {
            cond = function(client) return client.name == "eslint" and vim.fn.exists ":EslintFixAll" > 0 end,
            {
              event = "BufWritePost",
              desc = "Fix all eslint errors",
              callback = function() vim.cmd.EslintFixAll() end,
            },
          },
        },
        handlers = { tsserver = false }, -- disable tsserver setup, this plugin does it
        config = {
          ["typescript-tools"] = { -- enable inlay hints by default for `typescript-tools`
            settings = {
              tsserver_file_preferences = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
              expose_as_code_action = {
                -- "fix_all",
                "add_missing_imports",
                "remove_unused",
                "remove_unused_imports",
                "organize_imports",
              },
              tsserver_max_memory = 3072,
            },
          },
        },
        -- settings = {
        --   single_file_support = false,
        --   -- root_dir = function() end,
        --   -- root_dir = function() end,
        -- },
      },
    },
    ft = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    -- get AstroLSP provided options like `on_attach` and `capabilities`
    opts = function(_, opts)
      local astrolsp_avail, astrolsp = pcall(require, "astrolsp")
      -- -- New
      -- opts.server = astrolsp_avail and astrolsp.lsp_opts "typescript-tools"
      -- opts.server.root_dir = require("lspconfig.util").root_pattern ".git"
      -- return opts
      -- Old
      if astrolsp_avail then return astrolsp.lsp_opts "typescript-tools" end
    end,
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    config = function()
      local dap = require "dap"
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
      local js_config = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
      }

      if not dap.configurations.javascript then
        dap.configurations.javascript = js_config
      else
        require("astrocore").extend_tbl(dap.configurations.javascript, js_config)
      end
    end,
  },
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      autocmds = {
        -- set up autocommand to choose the correct language server
        typescript_deno_switch = {
          {
            event = "LspAttach",
            callback = function(args)
              local bufnr = args.buf
              local curr_client = vim.lsp.get_client_by_id(args.data.client_id)

              -- if denols attached, disable prettierd in null-ls
              -- and stop any attached typescript-tools clients
              if curr_client and curr_client.name == "denols" then
                local null_ls = require "null-ls"
                for _, source in ipairs(null_ls.get_sources()) do
                  if source.name == "prettierd" and source.methods.NULL_LS_FORMATTING == true then
                    null_ls.disable "prettierd"
                    break
                  end
                end

                local clients = (vim.lsp.get_clients) {
                  bufnr = bufnr,
                  name = "typescript-tools",
                }
                for _, client in ipairs(clients) do
                  vim.lsp.stop_client(client.id, true)
                end
              end

              -- if typescript-tools attached, stop any attached denols clients
              if curr_client and curr_client.name == "typescript-tools" then
                if next((vim.lsp.get_clients) { bufnr = bufnr, name = "denols" }) then
                  vim.lsp.stop_client(curr_client.id, true)
                end
              end
            end,
          },
        },
      },
    },
  },
}
