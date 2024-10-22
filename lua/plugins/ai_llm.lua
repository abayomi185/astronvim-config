---@type LazySpec
return {
  -- NOTE: gen.nvim
  {
    "abayomi185/gen.nvim",
    -- dir = "~/s-projek/gen.nvim",
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
    },
    opts = function(_, _)
      return {
        auto_save_chats = true,
        strategies = {
          -- Default adapter is openai
          chat = { adapter = "copilot" },
          inline = { adapter = "copilot" },
          agent = { adapter = "copilot" },
        },
        adapters = {
          -- openai = require("codecompanion.adapters").extend("openai", {
          --   env = {
          --     api_key = "cmd:age -d -i ~/.ssh/id_ed25519 ~/.openai-api-key.age",
          --   },
          -- }),
          -- strategies = {
          --   chat = "openai",
          --   inline = "openai",
          -- },
          openai = function()
            return require("codecompanion.adapters").extend("openai", {
              env = {
                api_key = "cmd:age -d -i ~/.ssh/id_ed25519 ~/.openai-api-key.age",
              },
            })
          end,
        },
        default_prompts = {
          ["Yomi"] = {
            strategy = "chat",
            description = "Open/restore a chat buffer to converse with an LLM",
            opts = {
              mapping = "<LocalLeader>ci",
              -- default_prompt = true,
              -- modes = { "n", "v" },
              slash_cmd = "custom",
              auto_submit = false,
              stop_context_insertion = true,
              -- user_prompt = true,
            },
            prompts = {
              {
                role = "system",
                condition = function(context) return context.is_visual end,
                content = function(context)
                  return "Don't make reponses overly verbose. Keep them short and conscise where possible.\n"
                    .. "Respond as a knowledgeable and intelligent person known as AGI Yomi.\n"
                    .. "Respond as someone knowledgeable about "
                    .. context.filetype
                    .. "."
                end,
              },
              {
                role = "user_header",
                contains_code = true,
                condition = function(context) return context.is_visual end,
                content = function(context)
                  local text = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
                  return "\n```" .. context.filetype .. "\n" .. text .. "\n```\n\n"
                end,
              },
            },
          },
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
