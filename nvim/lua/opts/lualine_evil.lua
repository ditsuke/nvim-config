-- Author: ditsuke
-- Credit: shadmansaleh, glepnir

-- Color table for highlights
-- Eviline-ish configuration for lualine

local shared = require("config.shared")
local icons = require("lazyvim.config.init").icons

local COLORS = {
  bg = "#202328",
  fg = "#bbc2cf",
  yellow = "#ECBE7B",
  cyan = "#008080",
  darkblue = "#081633",
  green = "#98be65",
  orange = "#FF8800",
  violet = "#a9a1e1",
  magenta = "#c678dd",
  blue = "#51afef",
  red = "#ec5f67",
}

local MODE_COLOR_MAP = {
  n = COLORS.red,
  i = COLORS.green,
  v = COLORS.blue,
  [""] = COLORS.blue,
  V = COLORS.blue,
  c = COLORS.magenta,
  no = COLORS.red,
  s = COLORS.orange,
  S = COLORS.orange,
  [""] = COLORS.orange,
  ic = COLORS.yellow,
  R = COLORS.violet,
  Rv = COLORS.violet,
  cv = COLORS.red,
  ce = COLORS.red,
  r = COLORS.cyan,
  rm = COLORS.cyan,
  ["r?"] = COLORS.cyan,
  ["!"] = COLORS.red,
  t = COLORS.red,
}

local conditions = {
  buffer_not_empty = function() return vim.fn.empty(vim.fn.expand("%:t")) ~= 1 end,
  hide_in_width = function() return vim.fn.winwidth(0) > 80 end,
  check_git_workspace = function()
    local filepath = vim.fn.expand("%:p:h")
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

local components = {
  filetype_plus_lsp = function()
    local ft = vim.bo.filetype
    local lsp = shared.get_active_lsp()
    if lsp ~= nil then return string.format("%s ( %s)", ft, lsp) end
    return ft
  end,
  copilot_icon = function() return icons.kinds.Copilot end,
}

local M = {}

M.config = function()
  return {
    options = {
      -- Disable sections and component separators
      component_separators = "",
      section_separators = "",
      theme = {
        -- We are going to use lualine_c an lualine_x as left and
        -- right section. Both are highlighted by c theme .  So we
        -- are just setting default looks o statusline
        normal = { c = { fg = COLORS.fg, bg = COLORS.bg } },
        inactive = { c = { fg = COLORS.fg, bg = COLORS.bg } },
      },
    },
    sections = {
      -- these are to remove the defaults
      lualine_a = {},
      lualine_b = {},
      lualine_y = {},
      lualine_z = {},

      lualine_c = {
        {
          function() return "▊" end,
          color = { fg = COLORS.blue }, -- Sets highlighting of component
          padding = { left = 0, right = 1 }, -- We don't need space before this
        },
        {
          -- mode component
          function() return "" end,
          color = function()
            -- auto change color according to neovims mode
            return { fg = MODE_COLOR_MAP[vim.fn.mode()] }
          end,
        },
        {
          "branch",
          icon = "",
          color = { fg = COLORS.violet, gui = "bold" },
        },
        {
          "filename",
          cond = conditions.buffer_not_empty,
          color = { fg = COLORS.magenta, gui = "bold" },
        },
        {
          "diff",
          -- Is it me or the symbol for modified us really weird
          symbols = { added = " ", modified = "柳", removed = " " },
          diff_color = {
            added = { fg = COLORS.green },
            modified = { fg = COLORS.orange },
            removed = { fg = COLORS.red },
          },
          cond = conditions.hide_in_width,
        },
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          symbols = { error = " ", warn = " ", info = " " },
          diagnostics_color = {
            color_error = { fg = COLORS.red },
            color_warn = { fg = COLORS.yellow },
            color_info = { fg = COLORS.cyan },
          },
        },
      },
      lualine_x = {
        {
          components.filetype_plus_lsp,
          color = { fg = "#ffffff", gui = "bold" },
        },
        {
          -- Copilot icon
          function() return "" end,
          cond = function() return package.loaded["copilot"] ~= nil end,
          color = { bg = COLORS.cyan, fg = "white" },
        },
        -- TODO: wakatime
        {
          "o:encoding", -- option component same as &encoding in viml
          fmt = string.upper, -- I'm not sure why it's upper case either ;)
          cond = conditions.hide_in_width,
          color = { fg = COLORS.green, gui = "bold" },
        },
        {
          "fileformat",
          fmt = string.upper,
          icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
          color = { fg = COLORS.green, gui = "bold" },
        },
        { "location" },
        { "progress", color = { fg = COLORS.fg, gui = "bold" } },
        {
          function() return "▊" end,
          color = { fg = COLORS.blue },
          padding = { left = 1 },
        },
      },
    },
    inactive_sections = {
      -- these are to remove the defaults
      lualine_a = {},
      lualine_b = {},
      lualine_y = {},
      lualine_z = {},
      lualine_c = {},
      lualine_x = {},
    },
  }
end

return M
