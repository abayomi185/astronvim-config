-- NOTE: This is a global function
P = function(v)
  print(vim.inspect(v))
  return v
end

local function addPythonPathToDapConfigs(configurations, venv_path)
  if not venv_path then return end
  for _, config in ipairs(configurations) do
    if (config.type == "python" or config.type == "debugpy") and config.pythonPath == nil then
      local pathSuffix = vim.fn.has "win32" == 1 and "/Scripts/python" or "/bin/python"
      config.pythonPath = venv_path .. pathSuffix
    end
  end
end

function _G.dump_lsp_config_to_buffer()
  -- Capture the output of the Lua command
  local output = vim.inspect(require("lspconfig").yamlls)

  -- Create a new buffer
  vim.cmd "new"

  -- Get the buffer number of the new buffer
  local bufnr = vim.api.nvim_get_current_buf()

  -- Insert the output into the new buffer
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, vim.split(output, "\n"))
end

-- Set spell checking for markdown files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function() vim.opt_local.spell = true end,
})

return {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "stable", -- "stable" or "nightly"
    version = "v3.*", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false, -- automatically quit the current session after a successful update
    remotes = { -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    },
  },

  -- Set colorscheme to use
  colorscheme = "onedark",

  -- add new user interface icon
  icons = {
    -- VimIcon = "",
    -- GitBranch = "",
    -- GitAdd = "",
    -- GitChange = "",
    -- GitDelete = "",
  },

  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  lsp = {
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
          -- "typescriptreact",
          -- "json"
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- "sumneko_lua",
        "tsserver",
        "jsonls",
        "lua_ls",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
    skip_setup = { "rust_analyzer" },
    mappings = {
      n = {
        ["<leader>ll"] = { "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "LSP CodeLens run" },
        ["<leader>lL"] = { "<cmd>lua vim.lsp.codelens.refresh()<cr>", desc = "LSP CodeLens refresh" },
      },
    },
  },

  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin", "matchparen" },
      },
    },
  },

  heirline = {
    separators = {
      path = " ❯ ",
      breadcrumbs = " » ",
      -- left = { "", " " }, -- separator for the left side of the statusline
      -- right = { " ", "" }, -- separator for the right side of the statusline
      -- tab = { "", "" },
      -- block = { "█", "" },
      custom_right = { " ", "" },
    },
    -- add new colors that can be used by heirline
    colors = function(hl)
      local C = require("astronvim.utils.status.env").fallback_colors
      local get_hlgroup = require("astronvim.utils").get_hlgroup
      --   local get_hlgroup = require("astronvim.utils").get_hlgroup
      --   -- use helper function to get highlight group properties
      --   local comment_fg = get_hlgroup("Comment").fg
      --   hl.git_branch_fg = comment_fg
      --   hl.git_added = comment_fg
      --   hl.git_changed = comment_fg
      --   hl.git_removed = comment_fg
      --   hl.blank_bg = get_hlgroup("Folded").fg
      --   hl.file_info_bg = get_hlgroup("Visual").bg
      --   hl.nav_icon_bg = get_hlgroup("String").fg
      --   hl.nav_fg = hl.nav_icon_bg
      --   hl.folder_icon_bg = get_hlgroup("Error").fg
      hl.tab_active_bg = get_hlgroup("TabLineFill", { fg = C.fg, bg = C.dark_bg })
      hl.tab_active_fg = get_hlgroup("TabLineSel", { fg = C.fg, bg = C.orange })
      return hl
    end,
    attributes = {
      -- mode = { bold = true },
      buffer_active = { bold = true, italic = false },
    },
    -- icon_highlights = {
    --   file_icon = {
    --     statusline = false,
    --   },
    -- },
  },

  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    -- TODO:
    -- DAP
    -- Style the tab bar

    -- NOTE: Some Docs
    -- Highlight group for LSP is changed in Onedarkpro theme

    -- @deprecated - Now using alpha.nvim to load last session
    -- Load last session if no args are passed to nvim
    -- if vim.fn.argc() == 0 then
    --   -- In case things go wrong
    --   -- require("resession").delete(vim.fn.getcwd(), { dir = "dirsession" })
    --   require("resession").load(vim.fn.getcwd(), { dir = "dirsession" })
    -- end

    -- Telescope file ignore patterns
    -- require('telescope').setup { defaults = { file_ignore_patterns = { "node_modules" } } }

    -- NOTE: Macros - 'quote' a word
    vim.api.nvim_set_keymap("n", "qw", ":silent! normal mpea'<Esc>bi'<Esc>`pl<CR>", { noremap = true })
    -- Double "quote" a word
    vim.api.nvim_set_keymap("n", "qd", ':silent! normal mpea"<Esc>bi"<Esc>`pl<CR>', { noremap = true })
    -- Remove quotes from a word
    vim.api.nvim_set_keymap("n", "wq", ":silent! normal mpeld bhd `ph<CR>", { noremap = true })

    -- Copilot colour
    vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

    -- Keep highlight after search
    vim.on_key(function() end, vim.api.nvim_get_namespaces()["auto_hlsearch"])

    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }

    -- NOTE: DAP
    -- Load launch.json
    -- require("dap.ext.vscode").json_decode = require("json5").parse
    -- Add remapping for debugpy
    require("dap.ext.vscode").load_launchjs(
      nil,
      { debugpy = { "python" }, rt_lldb = { "rust" }, ["probe-rs-debug"] = { "rust" } }
    )

    -- Debugpy adapter for dap needs to be set
    local dap = require "dap"
    dap.adapters.debugpy = dap.adapters.python

    addPythonPathToDapConfigs(dap.configurations.python, os.getenv "VIRTUAL_ENV" or os.getenv "CONDA_PREFIX")
  end,

  -- Bind the function to a command
  vim.cmd "command! DumpLSPConfig lua dump_lsp_config_to_buffer()",
}
