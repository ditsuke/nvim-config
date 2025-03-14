-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- ===================
-- Buffer navigation
-- ===================
-- vim.keymap.set("n", "<C-D>", "<C-D>zz")
-- vim.keymap.set("n", "<C-U>", "<C-U>zz")

-- vim.keymap.set("n", "n", "nzz")
-- vim.keymap.set("n", "N", "Nzz")

local UIUtils = require("ditsuke.utils.ui")

-- ==================
-- Buffer navigation
-- ==================

-- Reverse a folly from Lazyvim
pcall(function() vim.keymap.del("i", "<A-j>") end)
pcall(function() vim.keymap.del("i", "<A-k>") end)

-- Reverse insane new nvim defaults -- no one uses these!
pcall(function() vim.keymap.del("n", "grn") end)
pcall(function() vim.keymap.del("n", "grr") end)
pcall(function() vim.keymap.del("n", "gra") end)

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
  vim.keymap.set(
    mode,
    lhs,
    function() return vim.fn.pumvisible() == 1 and rhs or fb or lhs end,
    { expr = true, noremap = true }
  )
end

local function map_if_pumvisible(mode, lhs, rhs) map_if_pumvisible_else(mode, lhs, rhs, nil) end

-- Better command-completion mappings
map_if_pumvisible_else("c", "<C-k>", "<C-p>", "<Up>")
map_if_pumvisible_else("c", "<C-j>", "<C-n>", "<Down>")
map_if_pumvisible("c", "<Esc>", "<C-e>")
map_if_pumvisible("c", "<CR>", "<C-y>")

-- ===================
-- Behavior
-- ===================
vim.keymap.set("n", "J", "mzJ`z") -- Retain cursor position on line join w J
vim.keymap.set("v", "y", "ygv<Esc>") -- Retain cursor position on yank (https://reddit.com/comments/13y3thq/_/jmm7tut)

UIUtils.set_smart_visual_nav(true)

-- ============
--Utility
-- ============
vim.keymap.set("n", "<leader>ub", function()
  local background = vim.opt.background["_value"]
  if background == "dark" then
    print("Switching to light mode")
    vim.opt.background = "light"
  elseif background == "light" or background == "" then
    print("Switching to dark mode")
    vim.opt.background = "dark"
  else
    print("custom `background` set, can't switch modes")
  end
end, { desc = "Toggle [b]ackground (dark/light)" })

pcall(function() vim.keymap.del("n", "<leader>ud") end)
vim.keymap.set("n", "<leader>ud", function()
  vim.ui.select({ "lsp_lines", "stock", "none" }, { prompt = "Select style:" }, function(style)
    vim.diagnostic.config({ virtual_text = false, virtual_lines = false })
    if style == "lsp_lines" then
      vim.diagnostic.config({ virtual_lines = true })
    elseif style == "stock" then
      vim.diagnostic.config({ virtual_text = true })
    end
  end)
end, { desc = "Choose [d]iagnostics style" })

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank until EOL to system clipboard" })

-- Delete into oblivion 😈
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete selection, send to NULL register" })

-- Replace selection, sending it into oblivion 🙈
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Replace selection, send to NULL register" })

-- ====
-- UI
-- ====

vim.keymap.set({ "i", "n" }, "<esc>", function()
  vim.cmd.noh()
  UIUtils.close_floats()
  return "<esc>"
end, { expr = true, desc = "Escape, clear hlsearch and close floats" })

-- local state__wrap_enabled = false
-- vim.keymap.set("n", "<leader>uw", function()
--   if state__wrap_enabled then
--     UIUtils.set_wrap_with_keybindings(false)
--     state__wrap_enabled = false
--     vim.notify("Disabled wrap")
--   else
--     UIUtils.set_wrap_with_keybindings(true)
--     state__wrap_enabled = true
--     vim.notify("Enabled wrap")
--   end
-- end, { desc = "Toggle word wrap (with keybindings)" })

-- ============
-- OSX-compat
-- ============
local cmd_key_combos_to_map_to_c_leaders = {
  "Up",
  "Down",
  "Left",
  "Right",
  "o",
  "i",
  "d",
  "u",
}

for _, key in ipairs(cmd_key_combos_to_map_to_c_leaders) do
  vim.keymap.set("n", "<D-" .. key .. ">", "<C-" .. key .. ">", { remap = true })
end
