-- Author: ditsuke
-- Credit: shadmansaleh, glepnir

-- Color table for highlights
-- Eviline-ish configuration for lualine

local shared = require("config.shared")
local uv = vim.loop

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

local function fg(name)
  return function()
    ---@type {foreground?:number}?
    local hl = vim.api.nvim_get_hl_by_name(name, true)
    return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
  end
end

local conditions = {
  buffer_not_empty = function() return vim.fn.empty(vim.fn.expand("%:t")) ~= 1 end,
  hide_in_width = function() return vim.fn.winwidth(0) > 80 end,
  check_git_workspace = function()
    local filepath = vim.fn.expand("%:p:h")
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

local state = {
  comp_wakatime_time = "",
}

local components = {
  filetype_plus_lsp = function()
    local ft = vim.bo.filetype
    local lsp = shared.get_active_lsp()
    if lsp ~= nil then return string.format("%s ( %s)", ft, lsp) end
    return ft
  end,
  wakatime = function()
    local WAKATIME_UPDATE_INTERVAL = 10000

    if not Wakatime_routine_init then
      local timer = uv.new_timer()
      if timer == nil then return "" end
      -- Update wakatime every some some
      uv.timer_start(timer, 500, WAKATIME_UPDATE_INTERVAL, function()
        require("plenary.async").run(shared.get_wakatime_time, function(time) state.comp_wakatime_time = time end)
      end)
      Wakatime_routine_init = true
    end

    return state.comp_wakatime_time
  end,
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
          components.wakatime,
          cond = function() return vim.g["loaded_wakatime"] == 1 end,
          icon = "󱑆",
          color = { bg = COLORS.bg, fg = COLORS.cyan },
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
          function() return require("noice").api.status.command.get() end,
          cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
          color = fg("Statement"),
        },
        {
          function() return require("noice").api.status.mode.get() end,
          cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
          color = fg("Constant"),
        },
        {
          components.filetype_plus_lsp,
          color = { fg = "#ffffff", gui = "bold" },
        },
        {
          -- Copilot icon
          function() return "" end,
          cond = function() return package.loaded["copilot"] ~= nil end,
          color = function(_)
            return { bg = require("copilot.client").is_disabled() and COLORS.fg or COLORS.cyan, fg = "white" }
          end,
          on_click = function(clicks, button)
            local commands = require("copilot.command")

            if button ~= "l" or not vim.tbl_contains({ 1, 2 }, clicks) then
              vim.notify(
                [[Usage:
- **Single click:** Copilot status
- **Double click:** Toggle copilot
]],
                "info",
                { lang = "markdown" }
              )
              return
            end

            if clicks == 1 then
              commands.status()
              return
            end

            local disabled = require("copilot.client").is_disabled()
            if clicks == 2 then return disabled == true and commands.enable() == nil or commands.disable() end
          end,
        },
        {
          "encoding",
          -- fmt = string.upper,
          cond = conditions.hide_in_width,
          color = { fg = COLORS.green, gui = "bold" },
        },
        {
          "fileformat",
          fmt = string.upper,
          -- icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
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
