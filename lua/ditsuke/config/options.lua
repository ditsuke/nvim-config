-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.clipboard = "" -- **Do not** sync with the system clipboard
opt.mouse = "v" -- Disable mouse support by default

opt.laststatus = 3 -- Global statusline

opt.cursorline = true
opt.wrap = false
opt.timeoutlen = 0
opt.listchars = {
  trail = "·",
  precedes = "«",
  extends = "»",
  -- eol = "↲",
  tab = "▸ ",
}

-- Textwidth and auto-wrapping (disabled)
-- Read: http://blog.ezyang.com/2010/03/vim-textwidth
opt.textwidth = 120
local wanted_format_opts = "coqljp"
local unwanted_format_opts = "tc"
opt.formatoptions:remove(unwanted_format_opts .. wanted_format_opts)
opt.formatoptions:append(wanted_format_opts)

-- opt.spelloptions = "camel"

local UiUtils = require("ditsuke.utils.ui")
UiUtils.mini_indentscope_enabled(false)
UiUtils.indent_blankline_enabled(false)

-- Make window title indicative of our cwd
-- Loaded before normal autocmds (./autocmds) because we leverage the `VimEnter` here.
vim.api.nvim_create_autocmd({ "DirChanged", "VimEnter" }, {
  group = vim.api.nvim_create_augroup("update_window_title", { clear = true }),
  callback = function()
    local scope = (vim.v["event"] or {})["scope"]
    if scope == nil or scope == "global" then
      require("ditsuke.utils").set_window_title()
    end
  end,
})
