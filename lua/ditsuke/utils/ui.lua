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
  return false
  -- return true
  -- local ibl = require("ibl")
  -- if set_to ~= nil then
  --   ibl.setup_buffer(0, { enabled = set_to })
  -- end
  -- return require("ibl.config").get_config(0).enabled
end

local SPECIAL_FLOAT_FTS = {
  "hydra_hint",
  "which-key",
  "zenmode-bg",
  "TelescopePrompt",
  "TelescopeResults",
}
-- Close floating windows
-- Source: https://www.reddit.com/r/neovim/comments/1335pfc/comment/jiaagyi
function M.close_floats()
  local needs_hack = false
  local inactive_floating_wins = vim.fn.filter(vim.api.nvim_list_wins(), function(_, v)
    local file_type = vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(v), "filetype")
    if file_type == "noice" then
      needs_hack = true
    end

    return vim.api.nvim_win_get_config(v).relative ~= ""
      and v ~= vim.api.nvim_get_current_win()
      and not vim.tbl_contains(SPECIAL_FLOAT_FTS, file_type)
  end)

  -- If we're closing a noice float, we need to employ a hack
  -- to prevent the float to reopen on the top left under some scenarios (e.g., when we reopen it witout moving our cursor)
  vim.api.nvim_feedkeys("hl", "nt", true)
  -- if needs_hack then
  -- end
  -- for _, w in ipairs(inactive_floating_wins) do
  --   local file_type = vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(w), "filetype")
  --   local buftype = vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(w), "buftype")
  --   require("ditsuke.utils").logger("Closing float: " .. file_type .. " (" .. buftype .. ")")
  --   pcall(vim.api.nvim_win_close, w, false)
  -- end
end

-- Set smart jk navigation
-- Source: https://vim.fandom.com/wiki/Smart_navigation_using_j_and_k
function M.set_smart_visual_nav(enable)
  local keys_to_set = {
    "j",
    "k",
    -- "0",
    "^",
    -- "$",
  }

  for _, key in ipairs(keys_to_set) do
    if enable then
      vim.keymap.set(
        { "n", "v" },
        key,
        "v:count == 0 ? 'g" .. key .. "' : '" .. key .. "'",
        { expr = true, silent = true }
      )
    else
      pcall(vim.keymap.del, { "n", "v" }, key)
    end
  end
end

-- Set options related to wrapping
---@param enable boolean
function M.set_wrap(enable)
  vim.opt.wrap = enable
  vim.opt.list = enable
  vim.opt.linebreak = enable
end

-- Enable or disable wrap with keybindings
-- @param enable boolean
function M.set_wrap_with_keybindings(enable)
  if not enable then
    M.set_wrap(false)
    M.set_smart_visual_nav(false)
  else
    M.set_wrap(true)
    M.set_smart_visual_nav(true)
  end
end

function M.set_lualine_statusline(enable)
  if enable then
    vim.opt.laststatus = 3
    require("lualine").hide({ place = { "statusline" }, unhide = true })
  else
    vim.opt.laststatus = 0
    require("lualine").hide({ place = { "statusline" } })
  end
end

return M
