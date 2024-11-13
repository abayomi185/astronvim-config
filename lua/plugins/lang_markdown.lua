---@type LazySpec
return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      -- "echasnovski/mini.nvim", -- if you use the mini.nvim suite
      -- 'echasnovski/mini.icons' -- if you use standalone mini plugins
      "nvim-tree/nvim-web-devicons",
    },
    config = function() require("render-markdown").setup {} end,
  },
}
