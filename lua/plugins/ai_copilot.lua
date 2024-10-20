local function get_env_var(command)
  local handle = io.popen(command)
  local result = handle:read "*a"
  handle:close()
  return result:gsub("%s+$", "") -- trim trailing newline
end

---@type LazySpec
return {
  {
    "Exafunction/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function() require("codeium").setup {} end,
    enabled = false,
  },
  {
    "tzachar/cmp-ai",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      -- local api_key = get_env_var "gpg --decrypt ~/.openai-api-key.gpg 2>/dev/null"

      local cmp_ai = require "cmp_ai.config"
      cmp_ai:setup {
        max_lines = 20,
        provider = "Ollama",
        provider_options = {
          model = "phi:chat",
          base_url = "https://ollama-api.local.yomitosh.media/api/generate",
          system = [[
            You are an intelligent and helpful coding assistant named CodePilot.
            Your role is to assist the user in writing, debugging, and optimizing code across various programming languages and frameworks.
            Provide only code or comments relevant to the context.
            Avoid conversational responses.
            Always aim to improve code quality, readability, and efficiency.

            Key Functions:
            Code Completion: Provide context-aware code completions and snippets.
            Debugging: Identify and suggest fixes for syntax and logical errors in the code.
            Optimization: Offer ways to improve code performance and readability.
            Documentation: Generate comments and documentation for code segments.

            Guidelines:
            Ensure that suggestions follow best practices and coding standards.
            Be concise and avoid overly verbose code.
            When providing examples, use simple and clear code snippets.
            Respect the user's coding style and project constraints.
          ]],
        },
        notify = false,
        notify_callback = function(msg) vim.notify(msg) end,
        run_on_every_keystroke = true,
        ignored_file_types = {
          -- default is not to ignore
          -- uncomment to ignore in lua:
          -- lua = true
        },
      }
    end,
    enabled = false,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = { "Copilot" },
    event = { "User AstroFile" },
    opts = {
      suggestion = {
        enabled = false,
      },
      panel = { enabled = false },
      filetypes = {
        yaml = true,
        -- markdown = true,
      },
    },
    lazy = false,
  },
  {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua", "nvim-cmp" },
    config = function() require("copilot_cmp").setup() end,
    lazy = false,
  },
}
