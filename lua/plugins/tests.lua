local prefix = "<Leader>t"
return {
  {
    "nvim-neotest/neotest",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neotest/nvim-nio",
      "nvim-neotest/neotest-python",
      {
        "nvim-neotest/neotest-jest",
        opts = {
          -- jestConfigFile = function(file)
          --   if string.find(file, "/packages/") then return string.match(file, "(.-/[^/]+/)src") .. "jest.config.ts" end
          --
          --   return vim.fn.getcwd() .. "/jest.config.ts"
          -- end,
          -- -- May not need this below depending on the project
          -- cwd = function(file)
          --   if string.find(file, "/packages/") then return string.match(file, "(.-/[^/]+/)src") end
          --   return vim.fn.getcwd()
          -- end,

          jestConfigFile = "jest.config.ts",
          cwd = function(path) return vim.fn.getcwd() end,
        },
        config = function(_, opts) end,
      },
      {
        "AstroNvim/astrocore",
        opts = {
          mappings = {
            n = {
              [prefix] = { desc = "󰗇 Tests" },
              [prefix .. "t"] = { function() require("neotest").run.run() end, desc = "Run test" },
              [prefix .. "d"] = { function() require("neotest").run.run { strategy = "dap" } end, desc = "Debug test" },
              [prefix .. "f"] = {
                function() require("neotest").run.run(vim.fn.expand "%") end,
                desc = "Run all tests in file",
              },
              [prefix .. "p"] = {
                function() require("neotest").run.run(vim.fn.getcwd()) end,
                desc = "Run all tests in project",
              },
              [prefix .. "<CR>"] = { function() require("neotest").summary.toggle() end, desc = "Test Summary" },
              [prefix .. "o"] = { function() require("neotest").output.open() end, desc = "Output hover" },
              [prefix .. "O"] = { function() require("neotest").output_panel.toggle() end, desc = "Output window" },
              ["]T"] = { function() require("neotest").jump.next() end, desc = "Next test" },
              ["[T"] = { function() require("neotest").jump.prev() end, desc = "previous test" },
            },
          },
        },
      },
      {
        "folke/neodev.nvim",
        opts = function(_, opts)
          opts.library = opts.library or {}
          if opts.library.plugins ~= true then
            opts.library.plugins = require("astrocore").list_insert_unique(opts.library.plugins, { "neotest" })
          end
          opts.library.types = true
        end,
      },
    },
    opts = function(_, opts)
      if not opts.adapters then opts.adapters = {} end
      table.insert(opts.adapters, require "neotest-jest"(require("astrocore").plugin_opts "neotest-jest"))
      -- table.insert(opts.adapters, require "neotest-jest"({
      --     jestCommand = "npm test --",
      --     jestConfigFile = "custom.jest.config.ts",
      --     env = { CI = true },
      --     cwd = function(path)
      --       return vim.fn.getcwd()
      --     end,
      --   })
    end,
    config = function(_, opts)
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, vim.api.nvim_create_namespace "neotest")
      require("neotest").setup(opts)
    end,
  },
}
