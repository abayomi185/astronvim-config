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
      "ravitemer/codecompanion-history.nvim", -- For history management
      { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
      {
        "AstroNvim/astrocore",
        ---@type AstroCoreOpts
        opts = {
          mappings = {
            n = {
              ["<leader>lc"] = { "<cmd>CodeCompanionActions<cr>", desc = "Show CodeCompanion Actions" },
            },
            v = {
              ["<leader>lo"] = {
                "<cmd>CodeCompanionChat Add<CR>",
                desc = "Add selected text to CodeCompanion Chat",
              },
              ["<leader>lc"] = { "<cmd>CodeCompanionActions<cr>", desc = "Show CodeCompanion Actions" },
            },
          },
        },
      },
    },
    opts = function(_, _)
      return {
        strategies = {
          chat = { adapter = "copilot" },
          inline = {
            adapter = "copilot",
            keymaps = {
              accept_change = {
                modes = {
                  n = "ga",
                },
              },
              reject_change = {
                modes = {
                  n = "gA",
                },
              },
            },
          },
          agent = { adapter = "copilot" },
        },
        adapters = {
          http = {
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
                    default = "gpt-4.1",
                  },
                },
              })
            end,
            llamacpp = function()
              return require("codecompanion.adapters").extend("openai_compatible", {
                env = {
                  url = "http://127.0.0.1:8080",
                },
              })
            end,
          },
          acp = {
            qwen_code = function()
              return require("codecompanion.adapters").extend("gemini_cli", {
                commands = {
                  default = {
                    "qwen",
                    "--experimental-acp",
                  },
                },
                defaults = {
                  -- mcpServers = {},
                  timeout = 20000, -- 20 seconds
                },
              })
            end,
          },
        },
        display = {
          chat = {
            show_settings = false, -- Unable to change model in chat if true
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
        extensions = {
          history = {
            enabled = true,
            opts = {
              expiration_days = 30,
              picker = "snacks", --- ("telescope", "snacks", "fzf-lua", or "default")
              continue_last_chat = false,
              delete_on_clearing_chat = true,

              -- Memory system (requires VectorCode CLI)
              memory = {
                index_on_startup = true,
              },
            },
          },
        },
      }
    end,
    lazy = false,
  },
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      { "folke/snacks.nvim", opts = { input = { enabled = true } } },
    },
    specs = {
      {
        "AstroNvim/astrocore",
        ---@param opts AstroCoreOpts
        opts = function(_, opts)
          local maps = assert(opts.mappings)
          local prefix = "<Leader>i"
          maps.n[prefix] = { desc = require("astroui").get_icon("OpenCode", 1, true) .. "OpenCode" }
          maps.n[prefix .. "t"] = {
            function() require("opencode").toggle() end,
            desc = "Toggle embedded",
          }
          maps.n[prefix .. "a"] = {
            function() require("opencode").ask "@cursor: " end,
            desc = "Ask about this",
          }
          maps.n[prefix .. "i"] = {
            function() require("opencode").prompt("@buffer", { append = true }) end,
            desc = "Add buffer to prompt",
          }
          maps.n[prefix .. "e"] = {
            function() require("opencode").prompt "Explain @cursor and its context" end,
            desc = "Explain this code",
          }
          maps.n[prefix .. "n"] = {
            function() require("opencode").command "session_new" end,
            desc = "New session",
          }
          maps.n[prefix .. "s"] = {
            function() require("opencode").select() end,
            desc = "Select prompt",
          }
          maps.n["<S-C-u>"] = {
            function() require("opencode").command "messages_half_page_up" end,
            desc = "Messages half page up",
          }
          maps.n["<S-C-d>"] = {
            function() require("opencode").command "messages_half_page_down" end,
            desc = "Messages half page down",
          }

          maps.v[prefix] = { desc = require("astroui").get_icon("OpenCode", 1, true) .. "OpenCode" }
          maps.v[prefix .. "a"] = {
            function() require("opencode").ask "@selection: " end,
            desc = "Ask about selection",
          }
          maps.v[prefix .. "i"] = {
            function() require("opencode").prompt("@selection", { append = true }) end,
            desc = "Add selection to prompt",
          }
          maps.v[prefix .. "s"] = {
            function() require("opencode").select() end,
            desc = "Select prompt",
          }
        end,
      },
      { "AstroNvim/astroui", opts = { icons = { OpenCode = "" } } },
    },
  },
}
