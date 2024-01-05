-- return function(client, bufnr)
--   if client.server_capabilities.inlayHintProvider then
--     local inlayhints_avail, inlayhints = pcall(require, "lsp-inlayhints")
--     if inlayhints_avail then
--       inlayhints.on_attach(client, bufnr)
--       vim.keymap.set("n", "<leader>uH", function() inlayhints.toggle() end, { desc = "Toggle inlay hints" })
--     end
--   end
-- end
--
return function(client, bufnr)
  if client.supports_method "textDocument/documentHighlight" then
    vim.api.nvim_del_augroup_by_name "lsp_document_highlight"
  end
end
