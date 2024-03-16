-- See https://github.com/AstroNvim/AstroNvim/issues/1564 for discussion around this for Astronvim
return {
  "mrjones2014/legendary.nvim",
  event = "VeryLazy",
  -- dir = "~/oss-projek/legendary.nvim",
  opts = function()
    local builtin_mappings = astronvim.user_opts "mappings"

    local mappings = builtin_mappings
    -- local mappings = require("astronvim.utils").extend_tbl(builtin_mappings, user_mappings)

    return {
      extensions = {
        lazy_nvim = true,
        diffview = true,
        which_key = {
          mappings = mappings,
          do_binding = false,
          use_groups = false,
        },
      },
    }
  end,
  enabled = false,
}
