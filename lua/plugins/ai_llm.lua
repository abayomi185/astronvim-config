---@type LazySpec
return {
  -- NOTE: gen.nvim
  {
    "abayomi185/gen.nvim",
    opts = {
      model = "gemma_7b_instruct",
      command = "curl --silent --no-buffer -X POST https://astrysk-ollama-testflight.duckdns.org/api/chat -d $body",
      debug = true,
      no_auto_close = true,
      -- show_model = true,
      -- display_mode = "split",
      -- ollama_url = "https://astrysk-ollama-testflight.duckdns.org/api/generate",
    },
    lazy = false,
    enabled = false,
  },

  -- NOTE: llm.nvim
  {
    "abayomi185/llm.nvim",
    opts = {
      backend = "openai",
    },
    lazy = false,
    enabled = false,
  },

  -- NOTE: codecompanion
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp", -- Optional: For using slash commands and variables in the chat buffer
      "nvim-telescope/telescope.nvim", -- Optional: For using slash commands
      { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
      { "stevearc/dressing.nvim", opts = {} }, -- Optional: Improves `vim.ui.select`
    },
    opts = function(_, opts)
      return {
        auto_save_chats = true,
        strategies = {
          -- Default adapter is openai
          chat = { adapter = "copilot" },
          inline = { adapter = "copilot" },
        },
        adapters = {
          copilot = function() return require("codecompanion.adapters").extend("copilot", {}) end,
        },
        display = {
          chat = {
            show_settings = true,
          },
        },
      }
    end,
    lazy = false,
  },
}
