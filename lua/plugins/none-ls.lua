-- Customize None-ls sources

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  opts = function(_, config)
    -- config variable is the default configuration table for the setup function call
    local null_ls = require "null-ls"

    -- Check supported formatters and linters
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
      -- Set a formatter
      -- null_ls.builtins.formatting.stylua,
      -- null_ls.builtins.formatting.prettier,

      null_ls.builtins.formatting.stylua.with {
        filetypes = { "lua" },
      },

      null_ls.builtins.formatting.sqlfluff.with {
        filetypes = { "sql" },
        extra_args = { "--dialect", "mysql" },
      },

      null_ls.builtins.formatting.alejandra.with {
        filetypes = { "nix" },
      },

      -- Has native support for LSP
      -- null_ls.builtins.formatting.taplo.with {
      --   filetypes = { "toml" },
      -- },
      null_ls.builtins.formatting.black.with {
        filetypes = { "python" },
      },
      null_ls.builtins.formatting.isort.with {
        filetypes = { "python" },
        extra_args = { "--profile", "black" },
      },
      require("none-ls.diagnostics.eslint").with {
        filetypes = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "vue",
          "svelte",
        },
      },

      -- NOTE: Flake8 linter
      require("none-ls.diagnostics.flake8").with {
        filetypes = { "python" },
        extra_args = {
          "--format",
          "default",
          "--stdin-display-name",
          "$FILENAME",
          "-",
          "--count",
          "--max-line-length",
          "115",
          "--exclude=snapshots",
        },
      },
    }
    return config -- return final config table
  end,
}
