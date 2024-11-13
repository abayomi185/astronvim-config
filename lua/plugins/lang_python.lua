---@type LazySpec
return {
  {
    "AstroNvim/astrolsp",
    optional = true,
    ---@param opts AstroLSPOpts
    opts = {
      config = {
        python = {
          analysis = {
            typeCheckingMode = "basic",
            -- autoSearchPaths = true,
            -- useLibraryCodeForTypes = true,
            -- diagnosticMode = "workspace",
            -- typeCheckingMode = "basic",
            -- autoImportCompletions = true,
            -- autoSearchPaths = true,
            -- diagnosticSeverityOverrides = {
            --   reportUnusedImport = "information",
            --   reportMissingImports = "information",
            --   reportUndefinedVariable = "information",
            --   reportMissingTypeStubs = "information",
            --   reportMissingModuleSource = "information",
            -- },
          },
        },
      },
    },
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "nvim-neotest/neotest-python",
      opts = {
        is_test_file = function(file_path)
          -- Support all python file names
          if vim.endswith(file_path, ".py") then
            return true
          else
            return false
          end
        end,
      },
      config = function() end,
    },
    opts = function(_, opts)
      if not opts.adapters then opts.adapters = {} end
      table.insert(opts.adapters, require "neotest-python"(require("astrocore").plugin_opts "neotest-python"))
    end,
  },
}
