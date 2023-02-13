-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- ===================
-- Buffer navigation
-- ===================
vim.keymap.set("n", "<C-D>", "<C-D>zz")
vim.keymap.set("n", "<C-U>", "<C-U>zz")

vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

-- ===================
-- QoL and consistency
-- ===================

-- Navigate tab completion w/ <C-j> and <C-k>

--- Map `key` to `mapped_to` if the nvim-native popup
--- menu is visible.
---
--- @param mode string  Mode shortstring
--- @param lhs  string  LHS
--- @param rhs  string  RHS
---
--- @see https://vim.fandom.com/wiki/Improve_completion_popup_menu
local function map_if_pumvisible(mode, lhs, rhs)
  vim.keymap.set(mode, lhs, function()
    return vim.fn.pumvisible() == 1 and rhs or lhs
  end, { expr = true, noremap = true })
end

-- Better command-completion mappings
map_if_pumvisible("c", "<C-k>", "<C-p>")
map_if_pumvisible("c", "<C-j>", "<C-n>")
map_if_pumvisible("c", "<Esc>", "<C-e>")
map_if_pumvisible("c", "<CR>", "<C-y>")

-- ===================
-- Behavior
-- ===================
vim.keymap.set("n", "J", "mzJ`z")
