---@type LazySpec
return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
  },
  {
    "MeanderingProgrammer/markdown.nvim",
    name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      -- "echasnovski/mini.nvim", -- if you use the mini.nvim suite
      -- 'echasnovski/mini.icons' -- if you use standalone mini plugins
      "nvim-tree/nvim-web-devicons",
    },
    config = function() require("render-markdown").setup {} end,
  },
}
