return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "astronvim.utils.status"
    local hl = require "astronvim.utils.status.hl"
    local C = require("astronvim.utils.status.env").fallback_colors

    opts.tabline = { -- tabline
      unpack(opts.tabline),
      { -- file tree padding
        condition = function(self)
          self.winid = vim.api.nvim_tabpage_list_wins(0)[1]
          return status.condition.buffer_matches({
            filetype = {
              "NvimTree",
              "OverseerList",
              "aerial",
              "dap-repl",
              "dapui_.",
              "edgy",
              "neo%-tree",
              "undotree",
            },
          }, vim.api.nvim_win_get_buf(self.winid))
        end,
        provider = function(self) return string.rep(" ", vim.api.nvim_win_get_width(self.winid) + 1) end,
        hl = { bg = "tabline_bg" },
      },
      status.heirline.make_buflist(status.component.tabline_file_info {
        surround = {
          condition = function() return true end,
          separator = "custom_right",
          color = function(self) return self.tab_type == "buffer_active" and { left = C.blue } or C.none end,
        },
      }), -- component for each buffer tab
      status.component.fill { hl = { bg = "tabline_bg" } }, -- fill the rest of the tabline with background color
      { -- tab list
        condition = function() return #vim.api.nvim_list_tabpages() >= 2 end, -- only show tabs if there are more than one
        status.heirline.make_tablist { -- component for each tab
          provider = status.provider.tabnr(),
          hl = function(self)
            local attributes = status.hl.get_attributes(status.heirline.tab_type(self, "tab"), true)
            return attributes.fg
          end,
        },
        { -- close button for current tab
          provider = status.provider.close_button { kind = "TabClose", padding = { left = 1, right = 1 } },
          hl = status.hl.get_attributes("tab_close", true),
          on_click = {
            callback = function() require("astronvim.utils.buffer").close_tab() end,
            name = "heirline_tabline_close_tab_callback",
          },
        },
      },
    }

    opts.winbar = { -- create custom winbar
      -- store the current buffer number
      init = function(self) self.bufnr = vim.api.nvim_get_current_buf() end,
      fallthrough = false, -- pick the correct winbar based on condition
      -- inactive winbar
      {
        condition = function() return not status.condition.is_active() end,
        -- show the path to the file relative to the working directory
        status.component.separated_path { path_func = status.provider.filename { modify = ":.:h" } },
        -- add the file name and icon
        status.component.file_info {
          file_icon = { hl = status.hl.file_icon "winbar", padding = { left = 0 } },
          file_modified = false,
          file_read_only = false,
          hl = status.hl.get_attributes("winbarnc", true),
          surround = false,
          update = "BufEnter",
        },
      },
      -- active winbar
      {
        -- show the path to the file relative to the working directory
        status.component.separated_path { path_func = status.provider.filename { modify = ":.:h" } },
        -- add the file name and icon
        status.component.file_info { -- add file_info to breadcrumbs
          file_icon = { hl = status.hl.filetype_color, padding = { left = 0 } },
          file_modified = false,
          file_read_only = false,
          hl = status.hl.get_attributes("winbar", true),
          surround = false,
          update = "BufEnter",
        },
        -- show the breadcrumbs
        status.component.breadcrumbs {
          icon = { hl = true },
          hl = status.hl.get_attributes("winbar", true),
          prefix = true,
          padding = { left = 0 },
        },
      },
    }

    return opts
  end,
}
