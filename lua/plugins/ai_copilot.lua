---@type LazySpec
return {
  {
    "zbirenbaum/copilot.lua",
    cmd = { "Copilot" },
    event = { "User AstroFile" },
    opts = {
      suggestion = {
        enabled = false,
      },
      panel = { enabled = false },
      filetypes = {
        yaml = true,
        -- markdown = true,
      },
    },
    lazy = false,
  },
  {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua", "nvim-cmp" },
    config = function() require("copilot_cmp").setup() end,
    lazy = false,
  },
}
