-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

vim.o.sessionoptions = "buffers,curdir,tabpages,winsize,help,terminal,globals"

opt.clipboard = "" -- **Do not** sync with the system clipboard
opt.mouse = "v" -- Disable mouse support by default

opt.laststatus = 3 -- Global statusline

opt.cursorline = true
opt.wrap = false

opt.cmdheight = 0

-- Set a timeoutlen of 0 for instant response in normal/insert modes
-- However in terminal mode, we want to keep a non-zero timeoutlen as it is
-- essential in triggering mappings like `<Esc><Esc>` to exit terminal mode.
local timeoutlen = 0
opt.timeoutlen = timeoutlen
vim.api.nvim_create_autocmd({ "ModeChanged" }, {
  group = vim.api.nvim_create_augroup("update_timeoutlen", { clear = true }),
  callback = function()
    local mode = vim.api.nvim_get_mode().mode
    if mode == "t" then
      opt.timeoutlen = 200
    else
      opt.timeoutlen = timeoutlen
    end
  end,
})

-- Pretty display of whitespace characters.
-- Can be toggled with `:set list!`
opt.listchars = {
  trail = "·",
  precedes = "«",
  extends = "»",
  -- eol = "↲", -- This is a bit too much
  tab = "▸ ",
}

opt.fillchars = {
  vert = "▕",
  fold = " ",
  diff = "╱",
  msgsep = "‾",
  foldopen = "▾",
  foldsep = "│",
  foldclose = "▸",
  eob = " ",
}

-- Textwidth and auto-wrapping (disabled)
-- Read: http://blog.ezyang.com/2010/03/vim-textwidth
opt.textwidth = 120
local wanted_format_opts = "coqljp"
local unwanted_format_opts = "tc"
opt.formatoptions:remove(unwanted_format_opts .. wanted_format_opts)
opt.formatoptions:append(wanted_format_opts)

-- opt.spelloptions = "camel"
opt.spell = false

local UiUtils = require("ditsuke.utils.ui")
UiUtils.mini_indentscope_enabled(false)
UiUtils.indent_blankline_enabled(false)

vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
    ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
  },
}

-- Make window title indicative of our cwd
-- Loaded before normal autocmds (./autocmds) because we leverage the `VimEnter` event here.
vim.api.nvim_create_autocmd({ "DirChanged", "VimEnter" }, {
  group = vim.api.nvim_create_augroup("update_window_title", { clear = true }),
  callback = function()
    local scope = (vim.v["event"] or {})["scope"]
    if scope == nil or scope == "global" then
      require("ditsuke.utils").set_window_title()
    end
  end,
})
