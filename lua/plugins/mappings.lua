---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- PASSED: Normal Mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs with `H` and `L`
        L = {
          function() require("astrocore.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
          desc = "Next buffer",
        },
        H = {
          function() require("astrocore.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
          desc = "Previous buffer",
        },

        -- mappings seen under group name "Buffer"
        ["<Leader>bD"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Pick to close",
        },
        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        ["<Leader>b"] = { desc = "Buffers" },

        -- NOTE: Save
        ["<M-s>"] = { ":w<cr>", desc = "Save File" }, -- change description but the same command
        ["<Leader>W"] = { "<cmd>lua saveWithoutFormatting()<CR>", desc = "Save without formatting" },

        -- Terminal
        -- ["<C-t>"] = { "<cmd>ToggleTerm direction=float<CR>", desc = "ToggleTerm float" }, -- This is defined in ./toggleterm.lua

        ["<Leader>h"] = { ":nohlsearch<cr>", desc = "No Highlight" },

        -- ["<C-s>"] = ":w<CR>",
        -- ["<M-s>"] = ":w<CR>",

        -- NOTE: Git Diff
        ["<Leader>gd"] = { ":DiffviewOpen<cr>", desc = "Open Diff View" },
        ["<Leader>gD"] = { ":DiffviewClose<cr>", desc = "Close Git Diff" },

        -- NOTE: Git Signs
        ["<Leader>gn"] = { ":Gitsigns next_hunk<CR>", desc = "Next Hunk" },
        ["<Leader>gN"] = { ":Gitsigns prev_hunk<CR>", desc = "Previous Hunk" },

        -- NOTE: Legendary
        ["<C-p>"] = { ":Legendary<CR>", desc = "Toggle Legendary" },

        -- Move line
        ["<M-j>"] = ":m .+1<CR>==",
        ["<M-k>"] = ":m .-2<CR>==",

        ["<Leader>v"] = { "<C-v>", desc = "Visual Block" },

        -- NOTE: Telescope mappings
        -- ["<Leader>sg"] = ":Telescope grep_string<CR>",
        ["<Leader>fw"] = {
          "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
          desc = "Find Words",
        },
        ["<Leader>bm"] = {
          "<cmd>lua require('telescope.builtin').marks()<CR>",
          desc = "Telescope Marks",
        },

        -- NOTE: Custom workaround for vertical resize on macOS
        ["<C-M-l>"] = ":vertical resize -2<CR>",
        ["<C-M-h>"] = ":vertical resize +2<CR>",

        -- NOTE: Copilot mapping
        ["gp"] = ":Copilot panel<CR>",

        -- NOTE: Code Companion
        ["<Leader>lc"] = { "<cmd>CodeCompanionActions<CR>", desc = "Show CodeCompanion Actions" },
        ["<Leader>lt"] = { "<cmd>CodeCompanionToggle<CR>", desc = "Toggle CodeCompanion" },

        -- NOTE: Telescope mappings
        -- ["<Leader>ss"] = ":Telescope<CR>",

        -- NOTE: LSP mappings
        ["gh"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "Show hover" },
        -- ["<Leader>ll"] = { "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "LSP CodeLens run" },
        -- ["<Leader>lL"] = { "<cmd>lua vim.lsp.codelens.refresh()<cr>", desc = "LSP CodeLens refresh" },

        -- NOTE: Debug Mappings
        ["<Leader>db"] = { ":PBToggleBreakpoint<CR>", desc = "Toggle Breakpoint" },
        ["<Leader>dB"] = { ":PBClearAllBreakpoints<CR>", desc = "Clear All Breakpoints" },
        ["<Leader>dC"] = { ":PBSetConditionalBreakpoint<CR>", desc = "Set Conditional Breakpoint" },
        -- ["<Leader>dh"] = { function() require("dap.ui.widgets").preview() end, desc = "Debugger Hover" },
        -- Close all dap-ui hover windows
        -- ["<Leader>dx"] = { "", desc = "Close all dap-ui hovers" },

        -- NOTE: Spell Check
        -- ["zt"] = ":set spell!<CR>"

        -- NOTE: Buffer
        ["<Leader>bh"] = {
          "<cmd>lua require('astrocore.buffer').close_left()<CR>",
          desc = "Close all buffers to the left",
        },
        ["<Leader>bl"] = {
          "<cmd>lua require('astrocore.buffer').close_right()<CR>",
          desc = "Close all buffers to the right",
        },
        -- ["<Leader>br"] = false, -- Disabled for Legendary.nvim support

        -- NOTE: Harpoon
        ["<Leader>m"] = { name = "Harpoon" },
        ["<Leader>mm"] = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", desc = "Quick Menu" },
        ["<Leader>mt"] = { "<cmd>lua require('harpoon.ui').toggle_file()<CR>", desc = "Toggle File" },
        ["<Leader>ml"] = { "<cmd>lua require('harpoon.ui').nav_next()<CR>", desc = "Navigate next" },
        ["<Leader>mh"] = { "<cmd>lua require('harpoon.ui').nav_prev()<CR>", desc = "Navigate previous" },

        ["<Leader>1"] = { "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", desc = "Harpoon 1" },
        ["<Leader>2"] = { "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", desc = "Harpoon 2" },
        ["<Leader>3"] = { "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", desc = "Harpoon 3" },
        ["<Leader>4"] = { "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", desc = "Harpoon 4" },
        -- ["<Leader>5"] = { "<cmd>lua require('harpoon.ui').nav_file(5)<CR>", desc = "Harpoon 5" },

        -- NOTE: Live Grep
        -- lvim.builtin.which_key.mappings["st"] = {
        --   "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", "text-with-args"
        -- }

        -- NOTE: Rust
        ["<Leader>r"] = { name = "Rust" },
        ["<Leader>rj"] = { "<cmd>RustRunnables<Cr>", desc = "Runnables" },
        ["<Leader>rt"] = { "<cmd>lua _CARGO_TEST()<cr>", desc = "Cargo Test" },
        ["<Leader>rm"] = { "<cmd>RustExpandMacro<Cr>", desc = "Expand Macro" },
        ["<Leader>rc"] = { "<cmd>RustOpenCargo<Cr>", desc = "Open Cargo" },
        ["<Leader>rp"] = { "<cmd>RustParentModule<Cr>", desc = "Parent Module" },
        ["<Leader>rd"] = { "<cmd>RustDebuggables<Cr>", desc = "Debuggables" },
        ["<Leader>rv"] = { "<cmd>RustViewCrateGraph<Cr>", desc = "View Crate Graph" },
        ["<Leader>rR"] = {
          "<cmd>lua require('rust-tools/workspace_refresh')._reload_workspace_from_cargo_toml()<Cr>",
          desc = "Reload Workspace",
        },

        -- NOTE: Crates
        ["<Leader>R"] = { name = "Crates" },
        ["<Leader>Ro"] = { "<cmd>lua require('crates').show_popup()<CR>", desc = "Show popup" },
        ["<Leader>Rr"] = { "<cmd>lua require('crates').reload()<CR>", desc = "Reload" },
        ["<Leader>Rv"] = { "<cmd>lua require('crates').show_versions_popup()<CR>", desc = "Show Versions" },
        ["<Leader>Rf"] = { "<cmd>lua require('crates').show_features_popup()<CR>", desc = "Show Features" },
        ["<Leader>Rd"] = {
          "<cmd>lua require('crates').show_dependencies_popup()<CR>",
          desc = "Show Dependencies Popup",
        },
        ["<Leader>Ru"] = { "<cmd>lua require('crates').update_crate()<CR>", desc = "Update Crate" },
        ["<Leader>Ra"] = { "<cmd>lua require('crates').update_all_crates()<CR>", desc = "Update All Crates" },
        ["<Leader>RU"] = { "<cmd>lua require('crates').upgrade_crate<CR>", desc = "Upgrade Crate" },
        ["<Leader>RA"] = { "<cmd>lua require('crates').upgrade_all_crates(true)<CR>", desc = "Upgrade All Crates" },
        ["<Leader>RH"] = { "<cmd>lua require('crates').open_homepage()<CR>", desc = "Open Homepage" },
        ["<Leader>RR"] = { "<cmd>lua require('crates').open_repository()<CR>", desc = "Open Repository" },
        ["<Leader>RD"] = { "<cmd>lua require('crates').open_documentation()<CR>", desc = "Open Documentation" },
        ["<Leader>RC"] = { "<cmd>lua require('crates').open_crates_io()<CR>", desc = "Open Crate.io" },

        -- OSC52
        -- ["<Leader>y"] = { "<cmd>lua require('osc52').copy_operator()<CR>", desc = "OSC52 yank" },
        -- ["<Leader>yy"] = { "<leader>y_", desc = "OSC52 yank line" },

        ["gx"] = {
          function() require("astrocore").system_open(vim.fn.expand "<cfile>") end,
          desc = "Opens path/URI under cursor",
        },
      },

      -- PASSED: Visual Mode
      v = {
        ["<Leader>d"] = '"_d', -- register

        -- OSC52
        ["<Leader>y"] = { "<cmd>lua require('osc52').copy_visual()<CR>", desc = "OSC52 yank" },

        -- Move line
        ["<A-j>"] = ":m '>+1<CR>gv-gv",
        ["<A-k>"] = ":m '<-2<CR>gv-gv",

        -- Better indenting
        ["<"] = "<gv",
        [">"] = ">gv",

        -- NOTE: Code Companion
        ["<Leader>lc"] = { "<cmd>CodeCompanionActions<cr>", desc = "Show CodeCompanion Actions" },
        ["<Leader>lo"] = { "<cmd>CodeCompanionAdd<cr>", desc = "Add to CodeCompanion Chat" },
        ["<Leader>lt"] = { "<cmd>CodeCompanionToggle<cr>", desc = "Toggle CodeCompanion" },
      },

      -- PASSED: Terminal
      t = {
        -- setting a mapping to false will disable it
        -- ["<esc>"] = false,
        ["<C-space>"] = "<C-\\><C-n>",
        ["<C-k>"] = "<cmd>wincmd k<cr>",
      },
    },
  },
}
