return {
  {
    "rcarriga/nvim-notify",
    ---@type notify.Config
    opts = {
      top_down = false,
    },
  },
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
    opts = require("opts.lualine_evil").config,
  },
  {
    -- Winbar
    -- FIXME: despite the fix from #35, `navic` still refuses to work
    --  with barbecue.
    --  After further investigation, I found that the bug is reproducible in my older
    --  _lualine_ winbar, which begs the question if it's a navic bug or a bug
    --  with lazyvim's handling of navic (particularly, how it attaches to a
    --  LSP/buf).
    "ditsuke/barbecue.nvim", -- Wait for my PR to get merged
    branch = "chore/pass-winnr-to-custom-sections",
    name = "barbecue",
    -- version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      -- The navic config that ships with Lazyvim already attaches
      -- for us, besides `barbecue/issue#35`
      attach_navic = false,
      lead_custom_section = function(_, winnr)
        return string.format(" %d 󱋱 ", vim.api.nvim_win_get_number(winnr))
      end,
    },
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
