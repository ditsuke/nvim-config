local M = {}

M.setTitle = function()
M.NON_LSP_CLIENTS = { "", "copilot", "null-ls", "luasnip" }

M.set_window_title = function()
  local path = vim.split(vim.fn.getcwd(), "/", {})
  vim.opt.titlestring = [[%{v:progname}: ]] .. vim.fn.join({ path[#path - 1], path[#path] }, "/")
  vim.opt.title = true
end

M.get_active_lsp = function()
  for _, client in ipairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
    if not vim.tbl_contains(M.NON_LSP_CLIENTS, client.name) then
      return client.name
    end
  end
  return nil
end

return M
