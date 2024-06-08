return {
  {
    "mrjones2014/legendary.nvim",
    -- since legendary.nvim handles all your keymaps/commands,
    -- its recommended to load legendary.nvim before other plugins
    -- priority = 10000,
    lazy = false,
    -- sqlite is only needed if you want to use frecency sorting
    dependencies = { "kkharji/sqlite.lua" },
    opts = function()
      -- vim.notify("astrocore.which_key_queue before: " .. vim.inspect(which_key_mappings))

      -- local astrocore = require "astrocore"

      -- astrocore.set_mappings(astrocore.config.mappings)
      -- local which_key_mappings = astrocore.which_key_queue
      -- astrocore.which_key_queue = nil

      -- local which_key_mappings = astrocore.config.mappings

      -- vim.notify("astrocore.which_key_queue after: " .. vim.inspect(which_key_mappings))

      return {
        extensions = {
          lazy_nvim = true,
          diffview = true,
          which_key = {
            auto_register = false,
            -- mappings = which_key_mappings,
            do_binding = false,
            use_groups = false,
          },
        },
      }
    end,
    enabled = false,
  },
}
