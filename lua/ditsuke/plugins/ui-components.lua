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
    event = "VimEnter", -- Load on VimEnter to prevent blocking (_press enter to..._) notifications on startup
    priority = 1000, -- An attempt to make noice load before any blocking message comes in (from lazy).
    opts = {
      presets = {
        command_palette = true,
        bottom_search = false,
        long_message_to_split = true, -- long messages will be sent to a split
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      { "nvim-navic" },
    },
    opts = require("ditsuke.opts.lualine_evil").config,
  },

  -- A VS Code like winbar that uses nvim-navic in order to get LSP context from your language server.
  --
  -- FIXME: despite the fix from #35, `navic` still refuses to work
  --  with barbecue.
  --  After further investigation, I found that the bug is reproducible in my older
  --  _lualine_ winbar, which begs the question if it's a navic bug or a bug
  --  with lazyvim's handling of navic (particularly, how it attaches to a
  --  LSP/buf).
  {
    "utilyre/barbecue.nvim", -- Wait for my PR to get merged
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      -- The navic config that ships with Lazyvim already attaches
      -- for us, besides `barbecue/issue#35`
      attach_navic = false,
      -- Window number as leading section
      lead_custom_section = function(_, winnr)
        return string.format("  %d 󱋱 ", vim.api.nvim_win_get_number(winnr))
      end,

      exclude_filetypes = {
        "DressingInput",
        "neo-tree",
        "toggleterm",
        "Trouble",
      },
    },
  },

  -- >  A simple popup display that provides breadcrumbs feature using LSP server
  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
    },
    init = function()
      require("lazyvim.util").on_attach(function(client, buffer)
        if client.server_capabilities.documentSymbolProvider then
          require("nvim-navbuddy").attach(client, buffer)
        end
      end)
    end,
    keys = {
      { "<leader>cs", function() require("nvim-navbuddy").open() end, desc = "Open document [s]ymbol nagivator" },
    },
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = {
      {
        -- Scope buffers to tabs!
        "tiagovla/scope.nvim",
        config = true,
      },
    },
    ---@type bufferline.Config
    opts = {
      options = {
        separator_style = "thin",
        style_preset = require("bufferline.config").STYLE_PRESETS["minimal"],
        always_show_bufferline = true,
        show_buffer_close_icons = false,
        show_close_icon = false,
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
      },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
      vim.opt.showtabline = 0
    end,
    keys = {
      { "<leader>bj", "<Cmd>BufferLinePick<CR>", desc = "[b]uffer [j]ump" },
      { "<S-Right>", "<Cmd>BufferLineMoveNext<CR>", desc = "Move buffer right" },
      { "<S-Left>", "<Cmd>BufferLineMovePrev<CR>", desc = "Move buffer left" },
    },
  },
  { "kevinhwang91/nvim-bqf", ft = "qf", dependencies = { "junegunn/fzf", build = ":call fzf#install()" } },
}
