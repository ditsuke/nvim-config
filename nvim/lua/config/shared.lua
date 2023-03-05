local M = {}

M.setTitle = function()
  local path = vim.split(vim.fn.getcwd(), "/", {})
  vim.opt.titlestring = [[%{v:progname}: ]] .. vim.fn.join({ path[#path - 1], path[#path] }, "/")
  vim.opt.title = true
end

return M
