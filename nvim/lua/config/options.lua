-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.clipboard = "" -- **Do not** sync with the system clipboard
opt.mouse = "v" -- Disable mouse support by default

-- Make window title indicative of our cwd
-- TODO:auto-update on cwd change
local path = vim.split(vim.fn.getcwd(), "/", {})
vim.opt.titlestring = [[%{v:progname}: ]] .. vim.fn.join({ path[#path - 1], path[#path] }, "/")
vim.opt.title = true
