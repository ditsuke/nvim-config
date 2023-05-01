local M = {}

---@param set_to boolean|nil
function M.mini_indentscope_enabled(set_to)
  if set_to ~= nil then
    set_to = not set_to -- Since set_to -> enable but flag -> disable
    vim.g.miniindentscope_disable = set_to
  end
  return vim.g.miniindentscope_disable == nil and true -- Enabled by default
    or not vim.g.miniindentscope_disable
end

function M.indent_blankline_enabled(set_to)
  if set_to ~= nil then
    vim.g.indent_blankline_enabled = set_to
  end
  return vim.g.indent_blankline_enabled == nil and true -- Enabled by default
    or vim.g.indent_blankline_enabled
end

return M
