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

  -- NOTE: neo-tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    config = function(_, opts)
      opts.window = {
        position = "right",
        width = 30,
        mappings = {
          ["<space>"] = false, -- disable space until we figure out which-key disabling
          ["[b"] = "prev_source",
          ["]b"] = "next_source",
          o = "open",
          O = "system_open",
          h = "parent_or_close",
          l = "child_or_open",
          Y = "copy_selector",
        },
      }
      -- return opts
      require("neo-tree").setup(opts)
    end,
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
    },
  },
}
