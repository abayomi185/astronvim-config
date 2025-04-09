return {
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
      {
        "AstroNvim/astrocore",
        ---@type AstroCoreOpts
        opts = {
          mappings = {
            n = {
              ["<leader>lm"] = {
                "<cmd>MCPHub<CR>",
                desc = "Toggle MCPHub",
              },
            },
          },
        },
      },
    },
    event = "User AstroFile",
    cmd = "MCPHub",
    build = "bundled_build.lua",
    opts = {
      port = 3000,
      config = vim.fn.expand "~/mcpservers.json",
      use_bundled_binary = true,
      log = {
        level = vim.log.levels.WARN,
        to_file = false,
        file_path = nil,
        prefix = "MCPHub",
      },
    },
    specs = {
      -- {
      --   "olimorris/codecompanion.nvim",
      --   opts = {
      --     strategies = {
      --       chat = {
      --         tools = {
      --           ["mcp"] = {
      --             callback = require "mcphub.extensions.codecompanion",
      --             description = "Call tools and resources from the MCP Servers",
      --             opts = {
      --               user_approval = true,
      --             },
      --           },
      --         },
      --       },
      --     },
      --   },
      -- },
    },
  },
}
