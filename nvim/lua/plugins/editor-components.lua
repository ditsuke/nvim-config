local lazyUtils = require("lazyvim.util")

return {
  {
    -- Jump between files and terminals
    "ThePrimeagen/harpoon",
    event = "VeryLazy",
    keys = {
      { "m", function() require("harpoon.mark").add_file() end, desc = "Harpoon: [m]ark file" },
      { "`", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon: toggle quick menu" },
    },
  },
  {
    -- File tree
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        width = 30,
        position = "right",
      },
    },
    keys = function(_, keys)
      keys[#keys + 1] = {
        "<leader>o",
        function() require("neo-tree.command").execute({ focus = true }) end,
        desc = "Focus Neotree",
      }
      return keys
    end,
  },
  {
    -- Extensible fuzzy searcher for files, buffers, and virtually everything else
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && \
          cmake --build build --config Release && \
          cmake --install build --prefix build",
        config = function() require("telescope").load_extension("fzf") end,
      },
      {
        "nvim-telescope/telescope-frecency.nvim",
        dependencies = { { "kkharji/sqlite.lua" } },
        config = function() require("telescope").load_extension("frecency") end,
      },
      {
        -- Find terminals 👿
        "tknightz/telescope-termfinder.nvim",
        config = function() require("telescope").load_extension("termfinder") end,
      },
      {
        "debugloop/telescope-undo.nvim",
        config = function() require("telescope").load_extension("undo") end,
      },
    },
    keys = require("opts.telescope").keys,
    opts = require("opts.telescope").config,
  },
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-emoji",
      "f3fora/cmp-spell",
      "ray-x/cmp-treesitter",
      "saadparwaiz1/cmp_luasnip",
      "uga-rosa/cmp-dictionary",
      "onsails/lspkind.nvim",
    },
    opts = require("opts.cmp").config,
  },
  {
    -- Yet to use this but UndoTree here we go
    -- TODO: consider setting keymaps
    "mbbill/undotree",
  },
  {
    -- Zen mode for when I can't care for distractions
    -- TODO: keymap for toggle
    "folke/zen-mode.nvim",
    dependencies = { { "folke/twilight.nvim" } },
    opts = {
      window = {
        options = {
          signcolumn = "no", -- disable signcolumn
          number = false, -- disable number column
          relativenumber = false, -- disable relative numbers
          cursorline = false, -- disable cursorline
          cursorcolumn = false, -- disable cursor column
          foldcolumn = "0", -- disable fold column
          list = false, -- disable whitespace characters
        },
      },
      plugins = {
        options = {
          enabled = true,
          ruler = true,
          showcmd = true,
        },
        twilight = {
          enabled = false, -- NOTE: performs poorly
        },
        gitsigns = {
          enabled = true,
        },
      },
      on_open = function(_)
        vim.opt.laststatus = 0
        vim.opt.winbar = ""
      end,
      on_close = function() vim.opt.laststatus = 3 end,
    },
    -- stylua: ignore
    -- TODO: which-key leads for these keymaps
    keys = { { "<leader>zz", function() require("zen-mode").toggle() end, desc = "Toggle [z]enmode"} },
  },
  {
    -- Diagnostics with virtual text. Does multiline well
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = true,
  },
}
