-- WARN: This file breaks neovim and causes memory usage to go out of control

---@type LazySpec
return {
  -- NOTE: persistent-breakpoints
  {
    "Weissle/persistent-breakpoints.nvim",
    opts = {
      load_breakpoints_event = { "BufReadPost" },
    },
    lazy = false,
  },

  -- NOTE: nvim-dap-ui
  -- {
  --   "rcarriga/nvim-dap-ui",
  --   config = function(plugin, opts)
  --     -- run default AstroNvim nvim-dap-ui configuration function
  --     require "plugins.configs.nvim-dap-ui"(plugin, opts)
  --
  --     -- disable dap events that are created
  --     local dap = require "dap"
  --     -- dap.listeners.after.event_initialized["dapui_config"] = nil
  --     dap.listeners.before.event_terminated["dapui_config"] = nil
  --     dap.listeners.before.event_exited["dapui_config"] = nil
  --   end,
  --   opts = {
  --     layouts = {
  --       {
  --         elements = {
  --           {
  --             id = "scopes",
  --             size = 0.25,
  --           },
  --           {
  --             id = "breakpoints",
  --             size = 0.25,
  --           },
  --           {
  --             id = "stacks",
  --             size = 0.25,
  --           },
  --           {
  --             id = "watches",
  --             size = 0.25,
  --           },
  --         },
  --         position = "right",
  --         size = 40,
  --       },
  --       {
  --         elements = {
  --           {
  --             id = "repl",
  --             size = 0.5,
  --           },
  --           {
  --             id = "console",
  --             size = 0.5,
  --           },
  --         },
  --         position = "bottom",
  --         size = 10,
  --       },
  --     },
  --   },
  -- },

  -- NOTE: nvim-dap-probe-rs
  {
    "abayomi185/nvim-dap-probe-rs",
    config = function(plugin, opts) require("dap-probe-rs").setup() end,
    lazy = false,
    enabled = false,
  },
}
