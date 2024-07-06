return {
  {
    "mrjones2014/legendary.nvim",
    -- since legendary.nvim handles all your keymaps/commands,
    -- its recommended to load legendary.nvim before other plugins
    -- priority = 10000,
    -- lazy = false,
    event = "VeryLazy",
    -- sqlite is only needed if you want to use frecency sorting
    dependencies = { "kkharji/sqlite.lua" },
    opts = function()
      local which_key_mappings = require("astrocore").config.mappings

      -- Function to check if a value is a function
      local function is_function(val) return type(val[1]) == "function" end

      -- Function to filter mappings
      local function filter_mappings(mappings)
        for mode, keymaps in pairs(mappings) do
          for key, map in pairs(keymaps) do
            if is_function(map) then keymaps[key] = nil end
          end
        end
      end

      -- Filter the which_key_mappings
      filter_mappings(which_key_mappings)
      PB(which_key_mappings)

      pcall(require "legendary.extensions.codecompanion")

      return {
        extensions = {
          lazy_nvim = true,
          diffview = true,
          which_key = {
            auto_register = false,
            mappings = which_key_mappings,
            do_binding = false,
            -- use_groups = false,
          },
        },
      }
    end,
    enabled = false,
  },
}
