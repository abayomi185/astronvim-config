-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
local ui = require "astronvim.utils.ui"

return {
  -- NOTE: Normal Mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    -- ["<leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    -- ["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick to close" },
    -- ["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
    -- ["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    -- quick save
    ["<M-s>"] = { ":w<cr>", desc = "Save File" }, -- change description but the same command
    -- Terminal
    ["<C-t>"] = { ":ToggleTerm<cr>", desc = "ToggleTerm" },

    ["<leader>h"] = { ":nohlsearch<cr>", desc = "No Highlight" },

    -- ["<C-s>"] = ":w<CR>",
    -- ["<M-s>"] = ":w<CR>",

    -- Move line
    ["<M-j>"] = ":m .+1<CR>==",
    ["<M-k>"] = ":m .-2<CR>==",

    ["<S-l>"] = {
      function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Next buffer",
    },
    ["<S-h>"] = {
      function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Previous buffer",
    },

    ["<leader>v"] = { "<C-v>", desc = "Visual Block" },

    -- NOTE: Telescope mappings
    -- ["<leader>sg"] = ":Telescope grep_string<CR>",
    ["<leader>fw"] = {
      function() require("telescope").extensions.live_grep_args.live_grep_args() end,
      desc = "Find Words",
    },
    ["<leader>bf"] = { function() require("telescope.builtin").buffers() end, desc = "Buffer List" },

    -- NOTE: Custom workaround for vertical resize on macOS
    ["<C-M-l>"] = ":vertical resize -2<CR>",
    ["<C-M-h>"] = ":vertical resize +2<CR>",

    -- NOTE: Git Diff
    -- ["<leader>gD"] = { ":DiffviewClose<cr>", desc = "Close Git Diff" },

    -- NOTE: Copilot mapping
    ["gp"] = ":Copilot panel<CR>",

    -- NOTE: Telescope mappings
    -- ["<leader>ss"] = ":Telescope<CR>",

    -- NOTE: LSP mappings
    ["gh"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "Show hover" },
    -- ["<leader>ll"] = { "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "LSP CodeLens run" },
    -- ["<leader>lL"] = { "<cmd>lua vim.lsp.codelens.refresh()<cr>", desc = "LSP CodeLens refresh" },

    -- NOTE: Debug Mappings
    ["<leader>db"] = { ":PBToggleBreakpoint<CR>", desc = "Toggle Breakpoint" },
    ["<leader>dB"] = { ":PBClearAllBreakpoints<CR>", desc = "Clear All Breakpoints" },
    ["<leader>dC"] = { ":PBSetConditionalBreakpoint<CR>", desc = "Set Conditional Breakpoint" },
    -- ["<leader>dh"] = { function() require("dap.ui.widgets").preview() end, desc = "Debugger Hover" },
    -- Close all dap-ui hover windows
    -- ["<leader>dx"] = { "", desc = "Close all dap-ui hovers" },

    -- NOTE: Spell Check
    -- ["zt"] = ":set spell!<CR>"

    -- NOTE: Buffer
    ["<leader>bh"] = {
      function() require("astronvim.utils.buffer").close_left() end,
      desc = "Close all buffers to the left",
    },
    ["<leader>bl"] = {
      function() require("astronvim.utils.buffer").close_right() end,
      desc = "Close all buffers to the right",
    },
    ["<leader>br"] = false,

    -- NOTE: Harpoon
    ["<leader>m"] = { name = "Harpoon" },
    ["<leader>mm"] = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", desc = "Quick Menu" },
    ["<leader>mt"] = { "<cmd>lua require('harpoon.ui').toggle_file()<CR>", desc = "Toggle File" },
    ["<leader>ml"] = { "<cmd>lua require('harpoon.ui').nav_next()<CR>", desc = "Navigate next" },
    ["<leader>mh"] = { "<cmd>lua require('harpoon.ui').nav_prev()<CR>", desc = "Navigate previous" },

    ["<leader>1"] = { "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", desc = "Harpoon 1" },
    ["<leader>2"] = { "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", desc = "Harpoon 2" },
    ["<leader>3"] = { "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", desc = "Harpoon 3" },
    ["<leader>4"] = { "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", desc = "Harpoon 4" },
    -- ["<leader>5"] = { "<cmd>lua require('harpoon.ui').nav_file(5)<CR>", desc = "Harpoon 5" },

    -- NOTE: Neotree - built into Astro
    -- ["<leader>e"] = { "<cmd>Neotree toggle<CR>", desc = "Neotree" }

    -- NOTE: Live Grep
    -- lvim.builtin.which_key.mappings["st"] = {
    --   "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", "text-with-args"
    -- }

    -- NOTE: Rust
    ["<leader>r"] = { name = "Rust" },
    ["<leader>rj"] = { "<cmd>RustRunnables<Cr>", desc = "Runnables" },
    ["<leader>rt"] = { "<cmd>lua _CARGO_TEST()<cr>", desc = "Cargo Test" },
    ["<leader>rm"] = { "<cmd>RustExpandMacro<Cr>", desc = "Expand Macro" },
    ["<leader>rc"] = { "<cmd>RustOpenCargo<Cr>", desc = "Open Cargo" },
    ["<leader>rp"] = { "<cmd>RustParentModule<Cr>", desc = "Parent Module" },
    ["<leader>rd"] = { "<cmd>RustDebuggables<Cr>", desc = "Debuggables" },
    ["<leader>rv"] = { "<cmd>RustViewCrateGraph<Cr>", desc = "View Crate Graph" },
    ["<leader>rR"] = {
      "<cmd>lua require('rust-tools/workspace_refresh')._reload_workspace_from_cargo_toml()<Cr>",
      desc = "Reload Workspace",
    },

    -- NOTE: Crates
    ["<leader>R"] = { name = "Crates" },
    ["<leader>Ro"] = { "<cmd>lua require('crates').show_popup()<CR>", desc = "Show popup" },
    ["<leader>Rr"] = { "<cmd>lua require('crates').reload()<CR>", desc = "Reload" },
    ["<leader>Rv"] = { "<cmd>lua require('crates').show_versions_popup()<CR>", desc = "Show Versions" },
    ["<leader>Rf"] = { "<cmd>lua require('crates').show_features_popup()<CR>", desc = "Show Features" },
    ["<leader>Rd"] = { "<cmd>lua require('crates').show_dependencies_popup()<CR>", desc = "Show Dependencies Popup" },
    ["<leader>Ru"] = { "<cmd>lua require('crates').update_crate()<CR>", desc = "Update Crate" },
    ["<leader>Ra"] = { "<cmd>lua require('crates').update_all_crates()<CR>", desc = "Update All Crates" },
    ["<leader>RU"] = { "<cmd>lua require('crates').upgrade_crate<CR>", desc = "Upgrade Crate" },
    ["<leader>RA"] = { "<cmd>lua require('crates').upgrade_all_crates(true)<CR>", desc = "Upgrade All Crates" },
    ["<leader>RH"] = { "<cmd>lua require('crates').open_homepage()<CR>", desc = "Open Homepage" },
    ["<leader>RR"] = { "<cmd>lua require('crates').open_repository()<CR>", desc = "Open Repository" },
    ["<leader>RD"] = { "<cmd>lua require('crates').open_documentation()<CR>", desc = "Open Documentation" },
    ["<leader>RC"] = { "<cmd>lua require('crates').open_crates_io()<CR>", desc = "Open Crate.io" },

    -- OSC52
    -- ["<leader>y"] = { "<cmd>lua require('osc52').copy_operator()<CR>", desc = "OSC52 yank" },
    -- ["<leader>yy"] = { "<leader>y_", desc = "OSC52 yank line" },
  },

  -- NOTE: Visual Mode
  v = {
    ["<leader>d"] = '"_d', -- register

    -- OSC52
    ["<leader>y"] = { "<cmd>lua require('osc52').copy_visual()<CR>", desc = "OSC52 yank" },

    -- Move line
    ["<A-j>"] = ":m '>+1<CR>gv-gv",
    ["<A-k>"] = ":m '<-2<CR>gv-gv",

    -- Better indenting
    ["<"] = "<gv",
    [">"] = ">gv",
  },

  -- NOTE: Terminal Mode
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
    ["<leader><esc>"] = "<C-\\><C-n>",
    ["<C-space>"] = "<C-\\><C-n>",
  },
}
