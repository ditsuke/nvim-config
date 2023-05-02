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

UIUtils.set_smart_jk_nav()

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

-- Toggle mouse
local state__mouse = "a"
vim.keymap.set("n", "<leader>um", function()
  local now = vim.opt.mouse["_value"]
  vim.opt.mouse = state__mouse
  vim.notify('Set mouse to "' .. state__mouse .. '"')
  state__mouse = now
end, { desc = "Toggle [m]ouse support" })

local state__tabline = 0
vim.keymap.set("n", "<leader>ut", function()
  local now = vim.opt.showtabline["_value"]
  vim.opt.showtabline = state__tabline
  vim.notify('Set showtabline to "' .. state__tabline .. '"')
  state__tabline = now
end, { desc = "Toggle [t]abline" })

vim.keymap.set("n", "<leader>uIi", function()
  if UIUtils.indent_blankline_enabled() then
    UIUtils.indent_blankline_enabled(false)
    vim.notify("Disabled indent_blankline")
  else
    UIUtils.indent_blankline_enabled(true)
    vim.notify("Enabled indent_blankline")
  end
end, { desc = "Toggle indent_blankline" })

vim.keymap.set("n", "<leader>uII", function()
  if UIUtils.mini_indentscope_enabled() then
    UIUtils.mini_indentscope_enabled(false)
    vim.notify("Disabled mini.indentscope")
  else
    UIUtils.mini_indentscope_enabled(true)
    vim.notify("Enabled mini.indentscope")
  end
end, { desc = "Toggle mini.indentscope" })

local state__wrap_enabled = false
vim.keymap.set("n", "<leader>uw", function()
  if state__wrap_enabled then
    UIUtils.set_wrap_with_keybindings(false)
    vim.notify("Disabled wrap")
  else
    UIUtils.set_wrap_with_keybindings(true)
    vim.notify("Enabled wrap")
  end
end, { desc = "Toggle word wrap (with keybindings)" })

local state__statusline_enabled = true
if true then
  pcall(function() vim.keymap.del("n", "<leader>us") end)
  vim.keymap.set("n", "<leader>us", function()
    if state__statusline_enabled then
      state__statusline_enabled = false
      UIUtils.set_lualine_statusline(false)
      vim.notify("Disabled statusline")
    else
      state__statusline_enabled = true
      UIUtils.set_lualine_statusline(true)
      vim.notify("Enabled statusline")
    end
  end, { desc = "Toggle [s]tatusline (lualine)" })
end
