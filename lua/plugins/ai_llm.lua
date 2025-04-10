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
      "hrsh7th/nvim-cmp", -- Optional: For using slash commands and variables in the chat buffer
      "nvim-telescope/telescope.nvim", -- Optional: For using slash commands
      { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
      {
        "AstroNvim/astrocore",
        ---@type AstroCoreOpts
        opts = {
          mappings = {
            n = {
              ["<localleader>cc"] = {
                "<cmd>CodeCompanionChat Toggle<CR>",
                desc = "Toggle CodeCompanion Chat",
              },
            },
            v = {
              ["<localleader>ca"] = {
                "<cmd>CodeCompanionChat Add<CR>",
                desc = "Add selected text to CodeCompanion Chat",
              },
            },
          },
        },
      },
    },
    opts = function(_, _)
      return {
        strategies = {
          chat = { adapter = "copilot" },
          inline = { adapter = "copilot" },
          agent = { adapter = "copilot" },
        },
        adapters = {
          openai = function()
            return require("codecompanion.adapters").extend("openai", {
              env = {
                api_key = "cmd:age -d -i ~/.ssh/id_ed25519 ~/.openai-api-key.age",
              },
            })
          end,
          copilot = function()
            return require("codecompanion.adapters").extend("copilot", {
              schema = {
                model = {
                  default = "o3-mini", -- Use claude-3.5-sonnet as default over OpenAI GPT-4o
                },
              },
            })
          end,
        },
        display = {
          chat = {
            show_settings = true,
          },
        },
        prompt_library = {
          ["Generate Docstring"] = {
            strategy = "inline",
            description = "Generate a docstring for the selected code",
            opts = {
              is_slash_cmd = false,
              user_prompt = false,
            },
            prompts = {
              {
                role = "system",
                content = function(context)
                  return string.format(
                    [[You are a code generation assistant for %s. Your task is to generate a docstring for the given code. I want you to return raw code only (no codeblocks and no explanations). If you can't respond with code, respond with nothing]],
                    context.filetype
                  )
                end,
                opts = {
                  visible = false,
                  tag = "system_tag",
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
