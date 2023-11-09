return {
  {
    "rcarriga/nvim-notify",
    ---@type notify.Config
    opts = {
      top_down = false,
      render = "compact",
      stages = "static",
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
      lsp = {
        progress = {
          enabled = true,
          throttle = 100000 / 30,
        },
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
      require("lazyvim.util").lsp.on_attach(function(client, buffer)
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

  -- > Better quickfix window in Neovim, polish old quickfix window.
  { "kevinhwang91/nvim-bqf", ft = "qf", dependencies = { "junegunn/fzf", build = ":call fzf#install()" } },

  -- > 💥 Create key bindings that stick. WhichKey is a lua plugin for
  -- > Neovim 0.5 that displays a popup with possible keybindings of the
  -- > command you started typing.
  {
    "folke/which-key.nvim",
    ---@type Options
    opts = {
      window = {
        winblend = 10,
      },
      layout = {
        height = { min = 4, max = 15 },
        width = { min = 20, max = 50 },
      },
    },
    keys = {
      { "<C-/>", function() require("which-key").show() end, desc = "Show [h]elp", mode = { "n", "i" } },
    },
  },
  -- {
  --   "anuvyklack/hydra.nvim",
  --   enabled = true,
  -- },
}
