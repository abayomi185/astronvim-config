---@type LazySpec
return {
  {
    "AstroNvim/astrolsp",
    optional = true,
    ---@param opts AstroLSPOpts
    opts = {
      config = {
        python = {
          analysis = {
            typeCheckingMode = "basic",
            -- autoSearchPaths = true,
            -- useLibraryCodeForTypes = true,
            -- diagnosticMode = "workspace",
            -- typeCheckingMode = "basic",
            -- autoImportCompletions = true,
            -- autoSearchPaths = true,
            -- diagnosticSeverityOverrides = {
            --   reportUnusedImport = "information",
            --   reportMissingImports = "information",
            --   reportUndefinedVariable = "information",
            --   reportMissingTypeStubs = "information",
            --   reportMissingModuleSource = "information",
            -- },
          },
        },
      },
    },
  },
}
