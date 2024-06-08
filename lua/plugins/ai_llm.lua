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
    },
    opts = function(_, opts)
      return {
        adapters = {
          openai = require("codecompanion.adapters").use("openai", {
            env = {
              api_key = "cmd:gpg --decrypt ~/.openai-api-key.gpg 2>/dev/null",
            },
          }),
          strategies = {
            chat = "openai",
            inline = "openai",
          },
        },
        actions = {
          {
            name = "Custom Chat",
            strategy = "chat",
            description = "Open/restore a chat buffer to converse with an LLM",
            type = nil,
            prompts = {
              n = function() return require("codecompanion").chat() end,
              v = {
                {
                  role = "system",
                  content = function(context)
                    return "Don't make reponses overly verbose. Keep them short and conscise where possible.\n"
                      .. "Respond as a knowledgeable and intelligent person known as AGI Yomi.\n"
                      .. "Respond as someone knowledgeable about "
                      .. context.filetype
                      .. "."
                  end,
                },
                {
                  role = "user",
                  contains_code = true,
                  content = function(context)
                    local text = require("codecompanion.helpers.code").get_code(context.start_line, context.end_line)
                    return "\n```" .. context.filetype .. "\n" .. text .. "\n```\n\n"
                  end,
                },
              },
            },
          },
        },
      }
    end,
    lazy = false,
  },
}
