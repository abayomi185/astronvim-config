---@type LazySpec
return {
  {
    "j-hui/fidget.nvim",
    config = function() require("fidget").setup {} end,
    lazy = false,
  },
  {
    "AstroNvim/astrolsp",
    optional = true,
    ---@param opts AstroLSPOpts
    opts = {
      config = {
        snyk_ls = {
          init_options = {
            activateSnykCode = "true",
            trustedFolders = { "~/projek/*" },
            -- Tracking
            enableTelemetry = "false",
            sendErrorReports = "false",
          },
        },
      },
    },
  },
}
