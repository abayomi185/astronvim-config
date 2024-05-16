---@type LazySpec
return {
  {
    "olimorris/onedarkpro.nvim",
    -- priority = 1000,
    opts = {
      highlights = {
        LspReferenceText = { underline = true },
      },
      colors = {
        dark = {
          cursorline = "#22252b",
        },
        light = {
          cursorline = "#f0f0f0",
        },
      },
      options = {
        cursorline = true,
      },
    },
  },
  {
    "shellRaining/hlchunk.nvim",
    enabled = true,
    event = { "User AstroFile" },
    opts = {
      chunk = {
        enable = true,
        use_treesitter = true,
        chars = {
          horizontal_line = "━",
          vertical_line = "┃",
          left_top = "┏",
          left_bottom = "┗",
          right_arrow = "━",
        },
      },
      blank = {
        enable = false,
      },
      line_num = {
        enable = true,
        use_treesitter = true,
      },
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      scope = {
        -- highlight = { "IndentBlanklineContextChar" },
      },
    },
  },

  {
    "f-person/auto-dark-mode.nvim",
    opts = {
      set_dark_mode = function()
        -- vim.api.nvim_set_option("background", "dark")
        vim.cmd "colorscheme onedark"
      end,
      set_light_mode = function()
        -- vim.api.nvim_set_option("background", "light")
        vim.cmd "colorscheme onelight"
      end,
    },
  },

  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    init = function()
      vim.opt.laststatus = 3
      vim.opt.splitkeep = "screen"
    end,
    opts = {
      right = {
        { ft = "codecompanion", title = "Code Companion Chat", size = { width = 0.45 } },
      },
    },
  },
}
