return {
  {
    "rcarriga/nvim-dap-ui",
    -- opts = function(_, opts) return opts end,
    config = function(plugin, opts)
      -- run default AstroNvim nvim-dap-ui configuration function
      require "plugins.configs.nvim-dap-ui"(plugin, opts)

      -- disable dap events that are created
      local dap = require "dap"
      -- dap.listeners.after.event_initialized["dapui_config"] = nil
      dap.listeners.before.event_terminated["dapui_config"] = nil
      dap.listeners.before.event_exited["dapui_config"] = nil
    end,
  },
  {
    "abayomi185/nvim-dap-probe-rs",
    config = function(plugin, opts) require("dap-probe-rs").setup() end,
    lazy = false,
  },
}
