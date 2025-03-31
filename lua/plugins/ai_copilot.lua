local function get_env_var(command)
  local handle = io.popen(command)
  local result = handle:read "*a"
  handle:close()
  return result:gsub("%s+$", "") -- trim trailing newline
end

---@type LazySpec
return {
  {
    "tzachar/cmp-ai",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      -- local api_key = get_env_var "gpg --decrypt ~/.openai-api-key.gpg 2>/dev/null"

      local cmp_ai = require "cmp_ai.config"
      cmp_ai:setup {
        max_lines = 20,
        provider = "OpenAI",
        provider_options = {
          model = "gpt-3.5-turbo",
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
      copilot_node_command = "/home/nixos/.local/share/fnm/node-versions/v20.19.0/installation/bin/node",
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
