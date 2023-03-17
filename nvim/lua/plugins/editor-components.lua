local lazyUtils = require("lazyvim.util")

return {
  {
    -- Jump between files and terminals
    "ThePrimeagen/harpoon",
    event = "VeryLazy",
    keys = function()
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")

      return {
        { "m", mark.add_file },
        { "`", ui.toggle_quick_menu },
      }
    end,
  },
  {
    -- File tree
    "nvim-neo-tree/neo-tree.nvim",
    keys = function(_, keys)
      keys[#keys + 1] = {
        "<leader>o",
        function() require("neo-tree.command").execute({ focus = true }) end,
        desc = "Focus Neotree",
      }
      return keys
    end,
    opts = {
      window = {
        width = 30,
        position = "right",
      },
    },
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
      },
      {
        "nvim-telescope/telescope-frecency.nvim",
        dependencies = { { "kkharji/sqlite.lua" } },
        config = function() require("telescope").load_extension("frecency") end,
      },
      {
        -- Find terminals :devilous:
        "tknightz/telescope-termfinder.nvim",
        config = function() require("telescope").load_extension("termfinder") end,
      },
    },
    keys = {
      { "<leader>bs", require("telescope.builtin").buffers, desc = "Buffer Search" },
      {
        "<leader>st",
        function() require("telescope").extensions.termfinder.find({}) end,
        desc = "[t]erminals",
      },
      {
        "<leader>sS",
        lazyUtils.telescope("lsp_dynamic_workspace_symbols", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
          },
        }),
      },
      {
        "<leader>fr",
        function()
          require("telescope").extensions.frecency.frecency({
            workspace = "CWD",
          })
        end,
        desc = "[r]ecent",
      },
      {
        "<leader>tr",
        function() require("telescope.builtin").resume() end,
        desc = "[r]esume",
      },
    },
    opts = function(_, opts)
      local actions = require("telescope.actions")

      local fzf_opts = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      }

      local frecency_opts = {
        db_root = "~/.local/share/nvim",
      }

      local overrides = {
        extensions = {
          fzf = fzf_opts,
          frecency = frecency_opts,
        },
        pickers = {
          lsp_dynamic_workspace_symbols = {
            -- Manually set sorter, for some reason not picked up automatically
            sorter = require("telescope").extensions.fzf.native_fzf_sorter(fzf_opts),
          },
        },
        defaults = {
          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-J>"] = actions.move_selection_next,
              ["<C-K>"] = actions.move_selection_previous,
            },
          },
        },
      }

      return vim.tbl_deep_extend("force", opts, overrides)
    end,
    init = function() require("telescope").load_extension("fzf") end,
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
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = true,
  },
}
