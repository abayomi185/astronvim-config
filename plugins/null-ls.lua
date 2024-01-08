return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function(_, config)
    -- config variable is the default configuration table for the setup function call
    local null_ls = require "null-ls"

    -- Check supported formatters and linters
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
      -- Set a formatter
      -- null_ls.builtins.formatting.stylua,
      -- null_ls.builtins.formatting.prettier,

      -- NOTE: isort formatter
      -- null_ls.builtins.formatting.isort.with({
      --   filetypes = { "python" },
      --   extra_args = { "--line-length", "115" },
      -- }),

      -- NOTE: black formatter
      -- null_ls.builtins.formatting.black.with({
      --  filetypes = { "python" },
      --  extra_args = { "--line-length", "115" },
      --  }),

      -- NOTE: Flake8 linter
      null_ls.builtins.diagnostics.flake8.with {
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
