return {
  -- NOTE: neo-tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
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
      opts.filesystem.filtered_items.visible = true
    end,
  },

  -- NOTE: oil.nvim
  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = {
          mappings = {
            n = {
              ["<Leader>E"] = { function() require("oil").toggle_float() end, desc = "Open folder in Oil" },
            },
          },
          autocmds = {
            oil_settings = {
              {
                event = "FileType",
                desc = "Disable view saving for oil buffers",
                pattern = "oil",
                callback = function(args) vim.b[args.buf].view_activated = false end,
              },
              {
                event = "User",
                pattern = "OilActionsPost",
                desc = "Close buffers when files are deleted in Oil",
                callback = function(args)
                  if args.data.err then return end
                  for _, action in ipairs(args.data.actions) do
                    if action.type == "delete" then
                      local _, path = require("oil.util").parse_url(action.url)
                      local bufnr = vim.fn.bufnr(path)
                      if bufnr ~= -1 then require("astrocore.buffer").wipe(bufnr, true) end
                    end
                  end
                end,
              },
            },
          },
        },
      },
      {
        "rebelot/heirline.nvim",
        optional = true,
        dependencies = {
          "AstroNvim/astroui",
          opts = { status = { winbar = { enabled = { filetype = { "^oil$" } } } } },
        },
        opts = function(_, opts)
          if opts.winbar then
            local status = require "astroui.status"
            table.insert(opts.winbar, 1, {
              condition = function(self) return status.condition.buffer_matches({ filetype = "^oil$" }, self.bufnr) end,
              status.component.separated_path {
                padding = { left = 2 },
                max_depth = false,
                suffix = false,
                path_func = function(self) return require("oil").get_current_dir(self.bufnr) end,
              },
            })
          end
        end,
      },
    },
    opts = function()
      local get_icon = require("astroui").get_icon
      return {
        columns = {
          {
            "icon",
            default_file = get_icon "DefaultFile",
            directory = get_icon "FolderClosed",
          },
        },
        -- For more keymaps
        use_default_keymaps = false,
        keymaps = {
          ["g?"] = { "actions.show_help", mode = "n" },
          ["<CR>"] = "actions.select",
          ["<C-s>"] = { "actions.select", opts = { vertical = true } },
          ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
          ["gt"] = { "actions.select", opts = { tab = true } },
          ["gh"] = "actions.preview",
          ["<C-c>"] = { "actions.close", mode = "n" },
          ["<C-l>"] = "actions.refresh",
          ["-"] = { "actions.parent", mode = "n" },
          ["_"] = { "actions.open_cwd", mode = "n" },
          ["`"] = { "actions.cd", mode = "n" },
          ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
          ["gs"] = { "actions.change_sort", mode = "n" },
          ["gx"] = "actions.open_external",
          ["g."] = { "actions.toggle_hidden", mode = "n" },
          ["g\\"] = { "actions.toggle_trash", mode = "n" },
        },
      }
    end,
  },
  {
    "antosha417/nvim-lsp-file-operations",
    -- lazy will handle loading nvim-tree and neo-tree appropriately based on the module load and our `init` function
    lazy = true,
    -- lazily load plugin after a tree plugin is loaded
    init = function(plugin) require("astrocore").on_load({ "neo-tree.nvim", "nvim-tree.lua" }, plugin.name) end,
    dependencies = {
      "AstroNvim/astrolsp",
      opts = function(_, opts)
        local operations = vim.tbl_get(require("astrocore").plugin_opts "nvim-lsp-file-operations", "operations") or {}
        local fileOperations = {}
        for _, operation in ipairs { "willRename", "didRename", "willCreate", "didCreate", "willDelete", "didDelete" } do
          fileOperations[operation] = vim.F.if_nil(vim.tbl_get(operations, operation .. "Files"), true)
        end
        opts.capabilities =
          vim.tbl_deep_extend("force", opts.capabilities or {}, { workspace = { fileOperations = fileOperations } })
      end,
    },
    main = "lsp-file-operations", -- set the main module name where the `setup` function is
    opts = {},
    specs = {
      { "AstroNvim/astrolsp", opts = { file_operations = false } },
    },
  },
}
