-- CodeLLDB paths
-- local codelldb_path = vim.fn.stdpath('data') .. "/mason/packages/codelldb/extension/adapter/codelldb"
-- local liblldb_path = vim.fn.stdpath('data') .. "/mason/packages/codelldb/extension/lldb/lib/liblldb.dylib"
-- local utils = require "astronvim.utils"

return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },

  -- THEMES
  {
    "olimorris/onedarkpro.nvim",
    -- priority = 1000,
    opts = {
      highlights = {
        LspReferenceText = { underline = true },
      },
      colors = {
        cursorline = "#22252b"
      },
      options = {
        cursorline = true
      },
    }
  },
  -- NOTE: Already in AstroNvim
  -- {
  --   "windwp/nvim-ts-autotag",
  --   config = function()
  --     require("nvim-ts-autotag").setup()
  --   end,
  -- },
  -- TODO: Will need to see if required
  -- {
  --   "norcalli/nvim-colorizer.lua",
  --   config = function()
  --     require("colorizer").setup({ "*" }, {
  --       RGB = true,      -- #RGB hex codes
  --       RRGGBB = true,   -- #RRGGBB hex codes
  --       RRGGBBAA = true, -- #RRGGBBAA hex codes
  --       rgb_fn = true,   -- CSS rgb() and rgba() functions
  --       hsl_fn = true,   -- CSS hsl() and hsla() functions
  --       css = true,      -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
  --       css_fn = true,   -- Enable all CSS *functions*: rgb_fn, hsl_fn
  --     })
  --   end,
  -- },

  -- CMP
  { -- override nvim-cmp plugin
    "hrsh7th/nvim-cmp",
    -- override the options table that is used in the `require("cmp").setup()` call
    opts = function(_, opts)
      -- opts parameter is the default options table
      -- the function is lazy loaded so cmp is able to be required
      local cmp = require "cmp"
      -- modify the sources part of the options table
      opts.sources = cmp.config.sources {
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip",  priority = 750 },
        { name = "buffer",   priority = 500 },
        { name = "path",     priority = 250 },
      }

      -- return the new table to be used
      return opts
    end,
  },

  -- GIT
  {
    "sindrets/diffview.nvim",
    event = "User AstroGitFile",
    cmd = { "DiffviewOpen" },
  },
  {
    "NeogitOrg/neogit",
    optional = true,
    opts = { integrations = { diffview = true } },
  },

  -- DISCORD
  {
    'andweeb/presence.nvim',
    event = "User AstroLspSetup",
    opts = {
      main_image = "file",
    }
  },

  -- MARKDOWN
  {
    "npxbr/glow.nvim",
    ft = { "markdown" },
    cmd = { "Glow" },
  },
{
  "nvim-telescope/telescope.nvim",
  opts = function(_, opts)
    local actions = require "telescope.actions"
    opts.mappings = {
      i = {
        ["<C-j>"] = actions.cycle_history_next,
        ["<C-k>"] = actions.cycle_history_prev,
      },
    }
    return opts
  end
},
  -- OTHER
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
    lazy = false
  },
  {
    "rcarriga/nvim-notify",
    config = function(plugin, opts)
      require("plugins.configs.notify")(plugin, opts)
      local notify = require "notify"
      notify.setup({
        background_colour = "#000000"
      })
    end,
  },
  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").load_extension('harpoon')
      require("harpoon").setup()
    end,
    lazy = false
  },
  { "nvim-treesitter/playground" },
  {
    "romgrk/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup {
        enable = true,   -- Enable this plugin (Can be enabled/disabled later via commands)
        throttle = true, -- Throttles plugin updates (may improve performance)
        patterns = {
          -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
          -- For all filetypes
          -- Note that setting an entry here replaces all other patterns for this entry.
          -- By setting the 'default' entry below, you can control which nodes you want to
          -- appear in the context window.
          default = {
            'class',
            'function',
            'method',
          },
        },
      }
    end,
    lazy = false
  },
  {
    "RRethy/vim-illuminate",
    event = "User AstroFile",
    opts = {
      options = {
        delay = 120,
      }
    },
    config = function(_, opts) require("illuminate").configure(opts) end,
  },

  -- RUST
  {
    "simrat39/rust-tools.nvim",
    -- event = "User AstroLspSetup",
    -- config = function()
    --   require("rust-tools").setup({
    --     tools = {
    --       inlay_hints = {
    --         parameter_hints_prefix = "  ",
    --         other_hints_prefix = "  ",
    --       },
    --       autoSetHints = true,
    --       -- hover_with_actions = true,
    --       runnables = {
    --         use_telescope = true,
    --       },
    --       -- deprecated
    --       -- hover_actions = {
    --       --   auto_focus = true,
    --       -- },
    --     },
    --     server = {
    --       -- cmd_env = requested_server._default_options.cmd_env,

    --       -- on_init = require("lvim.lsp").common_on_init, -- Looks to be lvim specific
    --       on_attach = require("astronvim.utils.lsp").on_attach,

    --       settings = {
    --         ["rust-analyzer"] = {
    --           cargo = {
    --             allFeatures = true,
    --           },
    --           checkOnSave = {
    --             enable = true,
    --             command = "clippy",
    --           },
    --         }
    --       },
    --     },
    --     dap = {
    --       adapter = require('rust-tools.dap').get_codelldb_adapter(
    --         codelldb_path, liblldb_path)
    --     }
    --   })
    -- end,
    ft = { "rust", "rs" },
    -- init = function() astronvim.lsp.skip_setup = utils.list_insert_unique(astronvim.lsp.skip_setup, "rust_analyzer") end,
    opts = function()
      local adapter
      local success, package = pcall(function() return require("mason-registry").get_package "codelldb" end)
      if success then
        local package_path = package:get_install_path()
        local codelldb_path = package_path .. "/codelldb"
        local liblldb_path = package_path .. "/extension/lldb/lib/liblldb"
        local this_os = vim.loop.os_uname().sysname

        -- The liblldb extension is .so for linux and .dylib for macOS
        liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")

        adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
      else
        adapter = require("rust-tools.dap").get_codelldb_adapter()
      end
      return {
        tools = {
          inlay_hints = {
            parameter_hints_prefix = "  ",
            other_hints_prefix = "  ",
          },
          autoSetHints = true,
          -- hover_with_actions = true,
          runnables = {
            use_telescope = true,
          },
          -- deprecated
          -- hover_actions = {
          --   auto_focus = true,
          -- },
        },
        -- server = require("astronvim.utils.lsp").config "rust_analyzer",
        server = {
          -- cmd_env = requested_server._default_options.cmd_env,
          on_attach = require("astronvim.utils.lsp").on_attach,

          settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
              },
              checkOnSave = {
                enable = true,
                command = "clippy",
              },
            }
          },
        },
        dap = { adapter = adapter },
      }
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "rust_analyzer" },
    },
  },

  -- LSP
  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup()
    end,
    lazy = false
  },
  {
    'saecki/crates.nvim',
    event = { "BufRead Cargo.toml" },
    dependencies = { { 'nvim-lua/plenary.nvim' } },
    config = function()
      require('crates').setup()
    end,
  },

  -- FIXME:
  -- COPILOT
  {
    "zbirenbaum/copilot.lua",
    cmd = { "Copilot" },
    event = { "InsertEnter" },
    opts = {
      suggestion = {
        enabled = false
      },
      panel = { enabled = false }
    },
    lazy = false
  },
  {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua", "nvim-cmp" },
    config = function()
      require("copilot_cmp").setup()
    end,
    lazy = false
  },

  -- NOTE: Likely not needed
  -- TELESCOPE
  -- {
  --   "nvim-telescope/telescope-live-grep-args.nvim",
  --   config = function()
  --     require("telescope").load_extension("live_grep_args")
  --   end
  -- },
}
