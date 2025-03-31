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
    "ellisonleao/gruvbox.nvim",
    -- priority = 1000,
    config = true,
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
        duration = 0,
        delay = 0,
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
    event = { "User AstroFile" },
    main = "ibl",
    opts = {
      indent = {
        char = "│",
      },
      scope = {
        enabled = false,
      },
      exclude = {
        filetypes = { "help", "alpha", "dashboard", "Trouble", "lazy", "neo-tree" },
      },
      whitespace = {
        remove_blankline_trail = true,
      },
    },
  },
}
