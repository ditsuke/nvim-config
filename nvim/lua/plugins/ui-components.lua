return {
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        bottom_search = false,
        lsp_doc_border = true,
      },
    },
  },
  {
    -- TODO: review placement of diagnostics
    -- TODO: figure out a better strategy for filename -- currently
    --       winbar carries the bare filename while the statusline
    --       carries the full path
    -- TODO: add copilot button/icon that checks for activity
    "nvim-lualine/lualine.nvim",
    dependencies = {
      { "nvim-navic" },
    },
    opts = function(_, lop)
      local shared = require("config.shared")
      local FILESTATUS_SYMBOLS = { modified = "  ", readonly = "", unnamed = "" }
      local navic = require("nvim-navic")

      local root_base = function()
        local path = vim.split(vim.fn.getcwd(), "/", {})
        return path[#path]
      end

      local filetype_plus_lsp = function()
        local ft = vim.bo.filetype
        local lsp = shared.get_active_lsp()
        if lsp ~= nil then
          return string.format("%s (%s)", ft, lsp)
        end
        return ft
      end

      local window_number = function()
        return vim.api.nvim_win_get_number(0)
      end

      local winbar = {
        lualine_a = {
          {
            separator = "󱋱",
            window_number,
            icons_enabled = true,
            icon = { "", align = "left" },
          },
          {
            "filename",
            path = 0,
            symbols = FILESTATUS_SYMBOLS,
          },
        },
        lualine_b = {
          { navic.get_location, cond = navic.is_available, separator = { right = "" } },
        },
      }

      local inactive_winbar = {
        lualine_a = winbar.lualine_a,
      }

      local sections = {
        -- Mode
        lualine_a = {
          {
            "mode",
            fmt = function(str)
              return str:sub(1, 1)
            end,
            separator = { right = "|" },
          },
        },
        lualine_b = {
          -- Branch
          -- HACK: might break if lazyvim changes the order of sections
          lop.sections.lualine_b,
          { root_base, icons_enabled = true, icon = { "", align = "left" } },
          {
            "filename",
            path = 1,
            symbols = FILESTATUS_SYMBOLS,
            icon = { "", align = "left" },
            -- For the love of god, don't show filepath for toggleterm buffers
            cond = function()
              return vim.opt.filetype["_value"] ~= "toggleterm"
            end,
          },
        },
        -- File info
        lualine_c = {
          -- Diagnostics
          -- HACK: might break if lazyvim changes the order of the diagnostics
          lop.sections.lualine_c[1],
        },

        -- Workspace and git state
        lualine_x = lop.sections.lualine_x,
        lualine_y = {
          -- LSP status
          filetype_plus_lsp,
        },
        -- Location and filetype
        lualine_z = {
          { "fileformat", separator = "" },
          { "encoding", separator = "󰇝", padding = { right = 1 } },
          { "location", separator = "", padding = { left = 1, right = 1 } },
          { "progress", separator = "", padding = { right = 1 } },
        },
      }

      local options = {
        theme = "auto",
        globalstatus = true,
        -- On top of lazyvim's config, we disable the winbar for `neo-tree` (because lazyvim has no winbar)
        disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" }, winbar = { "neo-tree", "alpha" } },
      }

      lop.options = options
      lop.winbar = winbar
      lop.inactive_winbar = inactive_winbar
      lop.sections = sections
      return lop
    end,
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = {
      {
        -- Scope buffers to tabs
        "tiagovla/scope.nvim",
        opts = true,
      },
    },
    opts = {
      options = {
        separator_style = "slant",
        always_show_bufferline = true,
      },
    },
    keys = {
      { "<leader>bj", "<Cmd>BufferLinePick<CR>", desc = "[b]uffer [j]ump" },
      { "<S-Right>", "<Cmd>BufferLineMoveNext<CR>", desc = "Move buffer right" },
      { "<S-Left>", "<Cmd>BufferLineMovePrev<CR>", desc = "Move buffer left" },
    },
  },
}
