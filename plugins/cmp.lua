return {
  {
    "onsails/lspkind.nvim",
    opts = {
      symbol_map = {
        Copilot = "",
      },
    }
  },
  {                           -- override nvim-cmp plugin
    "hrsh7th/nvim-cmp",
    keys = { ":", "/", "?" }, -- lazy load cmp on more keys along with insert mode
    dependencies = {
      "hrsh7th/cmp-buffer",   -- add cmp-buffer as dependency of cmp
      "hrsh7th/cmp-cmdline",  -- add cmp-cmdline as dependency of cmp
    },
    config = function(plugin, opts)
      local cmp = require "cmp"

      local compare = require("cmp.config.compare")

      opts.sorting = {
        priority_weight = 2,
        comparators = {
          -- compare.score_offset, -- not good at all
          compare.locality,
          compare.recently_used,
          compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
          compare.offset,
          compare.order,
          -- compare.scopes, -- what?
          -- compare.sort_text,
          -- compare.exact,
          compare.kind,
          -- compare.length, -- useless
        },
      }

      opts.sources = cmp.config.sources {
        {
          name = "copilot",
          priority = 1500,
          -- keyword_length = 0,
          max_item_count = 3,
          trigger_characters = {
            {
              ".",
              ":",
              "(",
              "'",
              '"',
              "[",
              ",",
              "#",
              "*",
              "@",
              "|",
              "=",
              "-",
              "{",
              "/",
              "\\",
              "+",
              "?",
              " ",
              -- "\t",
              -- "\n",
            },
          },
        },
        {
          name = "nvim_lsp",
          priority = 1400
        },
        {
          name = "path",
          priority = 1300
        },
        {
          name = "luasnip",
          priority = 1200
        },
        {
          name = "cmp_tabnine",
          priority = 1100
        },
        {
          name = "nvim_lua",
          priority = 1000
        },
        {
          name = "buffer",
          priority = 900
        },
        {
          name = "calc",
          priority = 800
        },
        {
          name = "emoji",
          priority = 700
        },
        {
          name = "treesitter",
          priority = 600
        },
        {
          name = "crates",
          priority = 500
        },
        {
          name = "tmux",
          priority = 400
        },
      }

      -- run cmp setup
      cmp.setup(opts)

      -- configure `cmp-cmdline` as described in their repo: https://github.com/hrsh7th/cmp-cmdline#setup
      cmp.setup.cmdline({ "/", '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
          {
            { name = 'path' }
          },
          {
            { name = 'cmdline' }
          }
        )
      })
    end,
  },
}
