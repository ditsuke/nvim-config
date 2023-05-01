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

-- Close floating windows
-- Source: https://www.reddit.com/r/neovim/comments/1335pfc/comment/jiaagyi
-- TODO: While this closes floats, it does not diffuse handlers that focus floats on triggering them again (!)
--  as a result we're getting some weird artifacts on: open float -> close float -> open float again (without moving)
--  in order to investigate this behavior I'd have to see that the CursorMoved autocmd is doing (I don't know how to find it, though)
function M.close_floats()
  local inactive_floating_wins = vim.fn.filter(vim.api.nvim_list_wins(), function(_, v)
    local file_type = vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(v), "filetype")

    return vim.api.nvim_win_get_config(v).relative ~= ""
      and v ~= vim.api.nvim_get_current_win()
      and file_type ~= "hydra_hint"
  end)
  for _, w in ipairs(inactive_floating_wins) do
    pcall(vim.api.nvim_win_close, w, false)
  end
end

return M
