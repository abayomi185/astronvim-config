vim.api.nvim_create_user_command("AddMarkdownHeader", function()
  local date = tostring(os.date "### %Y-%m-%d")
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row = cursor[1] - 1
  vim.api.nvim_buf_set_lines(0, row, row, false, { date, "" })
end, {})
