local prefix = "<Leader>m"
---@type LazySpec
return {
  {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      local maps = opts.mappings

      -- Markdown mappings
      maps.n[prefix] = { desc = "󰍔 Markdown" }
      maps.n[prefix .. "b"] = {
        function()
          local lines = { "```", "", "```" }
          vim.api.nvim_put(lines, "l", true, true)
          vim.cmd "normal! k"
        end,
        desc = "Insert code block",
      }
      maps.n[prefix .. "c"] = {
        function() vim.api.nvim_put({ "- [ ] " }, "c", true, true) end,
        desc = "Insert checkbox",
      }
      maps.n[prefix .. "l"] = {
        function() vim.api.nvim_put({ "[link text](url)" }, "c", true, true) end,
        desc = "Insert link",
      }
      maps.n[prefix .. "a"] = {
        function() vim.api.nvim_put({ "![alt text](image_url)" }, "c", true, true) end,
        desc = "Insert image",
      }

      -- Headings
      maps.n[prefix .. "h"] = { desc = "Markdown Headings" }
      maps.n[prefix .. "hh"] = {
        function() vim.api.nvim_put({ "# " }, "c", true, true) end,
        desc = "Insert Heading 1",
      }
      maps.n[prefix .. "h2"] = {
        function() vim.api.nvim_put({ "## " }, "c", true, true) end,
        desc = "Insert Heading 2",
      }
      maps.n[prefix .. "h3"] = {
        function() vim.api.nvim_put({ "### " }, "c", true, true) end,
        desc = "Insert Heading 3",
      }
      maps.n[prefix .. "h4"] = {
        function() vim.api.nvim_put({ "#### " }, "c", true, true) end,
        desc = "Insert Heading 4",
      }
      maps.n[prefix .. "h5"] = {
        function() vim.api.nvim_put({ "##### " }, "c", true, true) end,
        desc = "Insert Heading 5",
      }

      maps.n[prefix .. "i"] = { desc = "Markdown items" }
      maps.n[prefix .. "ii"] = {
        function() vim.api.nvim_put({ "- " }, "c", true, true) end,
        desc = "Insert item",
      }
      maps.n[prefix .. "ic"] = {
        function() vim.api.nvim_put({ "- [ ] " }, "c", true, true) end,
        desc = "Insert checkbox",
      }
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      -- "echasnovski/mini.nvim", -- if you use the mini.nvim suite
      -- 'echasnovski/mini.icons' -- if you use standalone mini plugins
      "nvim-tree/nvim-web-devicons",
    },
    config = function() require("render-markdown").setup {} end,
  },
}
