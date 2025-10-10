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

  -- NOTE: VectorCode
  {
    "Davidyz/VectorCode",
    version = "*",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "VectorCode",
    lazy = false,
    specs = {
      {
        "olimorris/codecompanion.nvim",
        opts = {
          extensions = {
            vectorcode = {
              opts = {
                add_tool = true,
                add_slash_command = true,
                tool_opts = {},
              },
            },
          },
        },
      },
    },
  },

  -- NOTE: codecompanion
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp", -- Optional: For using slash commands and variables in the chat buffer
      "nvim-telescope/telescope.nvim", -- Optional: For using slash commands
      {
        -- For history management
        "ravitemer/codecompanion-history.nvim",
        specs = {
          {
            "olimorris/codecompanion.nvim",
            opts = {
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
            },
          },
        },
      },
      { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
      {
        "AstroNvim/astrocore",
        ---@type AstroCoreOpts
        opts = {
          mappings = {
            n = {
              ["<leader>lc"] = {
                "<cmd>CodeCompanionActions<cr>",
                desc = "Show CodeCompanion Actions",
              },
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
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        log_level = "DEBUG",
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
            copilot = function()
              return require("codecompanion.adapters").extend("copilot", {
                schema = {
                  model = {
                    default = "gpt-4.1",
                  },
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
      })
    end,
    lazy = false,
  },
}
