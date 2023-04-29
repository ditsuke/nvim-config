-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.clipboard = "" -- **Do not** sync with the system clipboard
opt.mouse = "v" -- Disable mouse support by default

opt.laststatus = 3 -- Global statusline

opt.cursorline = true
opt.wrap = false

-- opt.spelloptions = "camel"

-- Make window title indicative of our cwd
-- Loaded before normal autocmds (./autocmds) because we leverage the `VimEnter` here.
vim.api.nvim_create_autocmd({ "DirChanged", "VimEnter" }, {
  group = vim.api.nvim_create_augroup("update_window_title", { clear = true }),
  callback = function()
    local scope = (vim.v["event"] or {})["scope"]
    if scope == nil or scope == "global" then require("config.shared").set_window_title() end
  end,
})
