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
-- Window navigation
-- ===================
for i = 1, 6 do
  vim.keymap.set("n", "<leader>" .. i, i .. "<C-w>W", { desc = "Jump to window " .. i })
end

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
--- @param fb   string|nil  Fallback key triggered on popup absence.
---                         If `nil`, `lhs` is triggered instead.
---
--- @see https://vim.fandom.com/wiki/Improve_completion_popup_menu
local function map_if_pumvisible_else(mode, lhs, rhs, fb)
  vim.keymap.set(mode, lhs, function()
    return vim.fn.pumvisible() == 1 and rhs or fb or lhs
  end, { expr = true, noremap = true })
end

local function map_if_pumvisible(mode, lhs, rhs)
  map_if_pumvisible_else(mode, lhs, rhs, nil)
end

-- Better command-completion mappings
map_if_pumvisible_else("c", "<C-k>", "<C-p>", "<Up>")
map_if_pumvisible_else("c", "<C-j>", "<C-n>", "<Down>")
map_if_pumvisible("c", "<Esc>", "<C-e>")
map_if_pumvisible("c", "<CR>", "<C-y>")

-- ===================
-- Behavior
-- ===================
vim.keymap.set("n", "J", "mzJ`z") -- Retain cursor position on line join w J

-- Yank to system clipboard with `<leader>y`
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Delete into oblivion 😈
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Replace selection, sending it into oblivion 🙈
vim.keymap.set("x", "<leader>p", [["_dP]])
