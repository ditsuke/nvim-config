local M = {}

local FILESTATUS_SYMBOLS = { modified = "  ", readonly = "", unnamed = "" }

local shared = require("config.shared")

local function root_base()
  local path = vim.split(vim.fn.getcwd(), "/", {})
  return path[#path]
end

local function filetype_plus_lsp()
  local ft = vim.bo.filetype
  local lsp = shared.get_active_lsp()
  if lsp ~= nil then return string.format("%s (%s)", ft, lsp) end
  return ft
end

M.config = function(_, og_opts)
  local overrides = {
    -- winbar = winbar,
    -- inactive_winbar = {
    --   lualine_a = winbar.lualine_a,
    -- },
    sections = {
      -- Mode
      lualine_a = {
        {
          "mode",
          fmt = function(str) return str:sub(1, 1) end,
          separator = { right = "|" },
        },
      },
      lualine_b = {
        -- Branch
        -- HACK: might break if lazyvim changes the order of sections
        { root_base, icons_enabled = true, icon = { "", align = "left" } },
        { "branch", separator = { right = "|" } },
      },
      -- File info
      lualine_c = {
        -- Diagnostics
        -- HACK: might break if lazyvim changes the order of the diagnostics
        og_opts.sections.lualine_c[1],
      },

      -- Workspace and git state
      lualine_x = og_opts.sections.lualine_x,
      lualine_y = {
        -- LSP status
        -- {function() return vim.cmd.Waka},
        {
          function() return require("lazyvim.config.init").icons.kinds.Copilot end,
          cond = function() return package.loaded["copilot"] ~= nil end,
        },
        filetype_plus_lsp,
      },
      -- Location and filetype
      lualine_z = {
        { "fileformat", separator = "" },
        { "encoding", separator = "󰇝", padding = { right = 1 } },
        { "location", separator = "", padding = { left = 1, right = 1 } },
        { "progress", separator = "", padding = { right = 1 } },
      },
    },
    options = {
      theme = "auto",
      globalstatus = true,
      -- On top of lazyvim's config, we disable the winbar for `neo-tree` (because lazyvim has no winbar)
      disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" }, winbar = { "neo-tree", "alpha" } },
    },
  }

  return vim.tbl_deep_extend("force", og_opts, overrides)
end
return M
