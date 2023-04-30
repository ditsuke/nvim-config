local M = {}

M.NON_LSP_CLIENTS = { "", "copilot", "null-ls", "luasnip" }

M.get_active_lsp = function()
  for _, client in ipairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
    if not vim.tbl_contains(M.NON_LSP_CLIENTS, client.name) then
      return client.name
    end
  end
  return nil
end
