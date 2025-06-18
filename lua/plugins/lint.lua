local analyzers_path = vim.fn.trim(vim.fn.system "nix eval nixpkgs#vscode-js-debug.outPath --raw") .. "/share/plugins"

---@type LazySpec
return {
  {
    "https://gitlab.com/schrieveslaach/sonarlint.nvim",
    ft = {
      "c",
      "cpp",
      "css",
      "docker",
      "go",
      "html",
      "java",
      "javascript",
      "javascriptreact",
      "php",
      "python",
      "typescript",
      "typescriptreact",
      "xml",
      "yaml.docker-compose",
    },
    opts = {
      server = {
        cmd = {
          "sonarlint-language-server",
          "-stdio",
          "-analyzers",
          analyzers_path .. "sonargo.jar",
          analyzers_path .. "sonarhtml.jar",
          analyzers_path .. "sonarjs.jar",
          analyzers_path .. "sonarpython.jar",
          analyzers_path .. "sonarxml.jar",
        },
      },
      filetypes = sonarlint_ft,
    },
  },
}
