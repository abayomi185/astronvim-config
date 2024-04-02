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
}
