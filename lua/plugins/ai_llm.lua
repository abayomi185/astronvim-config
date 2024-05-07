---@type LazySpec
return {
  -- NOTE: gen.nvim
  {
    "abayomi185/gen.nvim",
    dir = "~/s-projek/gen.nvim",
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
    dir = "~/s-projek/llm.nvim",
    opts = {
      backend = "openai",
    },
    lazy = false,
    enabled = false,
  },

  -- NOTE: codecompanion
  {
    "olimorris/codecompanion.nvim",
    -- dir = "~/oss-projek/codecompanion.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- Optional: Improves the default Neovim UI
    },
    opts = function(_, opts)
      return {
        adapters = {
          openai = require("codecompanion.adapters").use("openai", {
            env = {
              api_key = "cmd:age -d -i ~/.ssh/id_ed25519 ~/.openai-api-key.age",
            },
          }),
          strategies = {
            chat = "openai",
            inline = "openai",
          },
        },
      }
    end,
    lazy = false,
  },
}
