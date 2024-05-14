---@type LazySpec
return {
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
            },
          },
        },
      },
    },
    ft = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    -- get AstroLSP provided options like `on_attach` and `capabilities`
    opts = function()
      local astrolsp_avail, astrolsp = pcall(require, "astrolsp")
      if astrolsp_avail then return astrolsp.lsp_opts "typescript-tools" end
    end,
  },
}
