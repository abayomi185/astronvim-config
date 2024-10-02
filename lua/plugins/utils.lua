---@type LazySpec
return {
  {
    "Joakker/lua-json5",
    build = "./install.sh",
    lazy = false,
  },
  {
    "nvim-treesitter/playground",
    enable = false,
  },

  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end,
    lazy = false,
  },

  -- NOTE: vim-illuminate
  {
    "RRethy/vim-illuminate",
    opts = {
      options = {
        delay = 120,
      },
    },
  },

  -- NOTE: nvim-notify
  {
    "rcarriga/nvim-notify",
    opts = {
      -- customize the notification position
      top_down = false,
      fps = 1,
    },
  },
}
