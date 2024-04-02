-- Customize None-ls sources

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
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

      null_ls.builtins.formatting.taplo.with {
        filetypes = { "toml" },
      },
      null_ls.builtins.formatting.black.with {
        filetypes = { "python" },
      },
      null_ls.builtins.formatting.isort.with {
        filetypes = { "python" },
        extra_args = { "--profile", "black" },
      },
      null_ls.builtins.formatting.prettierd.with {
        filetypes = {
          "typescript",
          "typescriptreact",
          "javascript",
          "javascriptreact",
          "vue",
          "svelte",
          "json",
          "jsonc",
          "markdown",
        },
      },
    }
    return config -- return final config table
  end,
}
