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
    branch = "main", -- override until fuzzy_finder_mappings is in 2.x
    opts = function(_, og)
      local icons = require("icons")
      local overrides = {
        -- auto_clean_after_session_restore = true,
        close_if_last_window = true,
        window = {
          width = 30,
          position = "right",
          fuzzy_finder_mappings = {
            ["<C-j>"] = "move_cursor_down",
            ["<C-k>"] = "move_cursor_up",
          },
        },
        default_component_configs = {
          indent = { padding = 0, indent_size = 1 },
          icon = {
            folder_closed = icons.states.folder_closed,
            folder_open = icons.states.folder_open,
            folder_empty = icons.states.folder_empty,
            default = icons.misc.default_file,
          },
          modified = { symbol = icons.states.file_modified },
          git_status = {
            symbols = {
              added = icons.git.added,
              deleted = icons.git.removed,
              modified = icons.git.modified,
              renamed = icons.git.renamed,
              untracked = icons.git.untracked,
              ignored = icons.git.ignored,
              unstaged = icons.git.unstaged,
              staged = icons.git.staged,
              conflict = icons.git.conflict,
            },
          },
        },
      }
      return vim.tbl_deep_extend("force", og, overrides)
    end,
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
    "L3MON4D3/LuaSnip",
    opts = function(_, og_opts)
      local types = require("luasnip.util.types")
      return vim.tbl_deep_extend("force", og_opts, {
        ext_opts = {
          [types.choiceNode] = {
            active = {
              virt_text = { { "●", "GruvboxOrange" } }, -- TODO: these colors only work with gruvbox, so figure a way to have them across themes
            },
          },
          [types.insertNode] = {
            active = {
              virt_text = { { "●", "GruvboxBlue" } },
            },
            passive = {
              virt_text = { { "_" } },
            },
            snippet_passive = {
              virt_text = { { "_" } },
            },
          },
        },
      })
    end,
    config = function(_, opts)
      local luasnip = require("luasnip")
      luasnip.setup(opts)

      -- Unlink active snippet on mode change to prevent accidental jumps and frustration
      -- Ref: https://github.com/L3MON4D3/LuaSnip/issues/656#issuecomment-1313310146
      -- Alternative that accounts for cursor position (to consider): https://github.com/L3MON4D3/LuaSnip/issues/747#issuecomment-1406946217
      vim.api.nvim_create_autocmd("ModeChanged", {
        group = vim.api.nvim_create_augroup("UnlinkLuaSnipSnippetOnModeChange", {
          clear = true,
        }),
        pattern = { "s:n", "i:*" },
        desc = "Forget the current snippet when leaving the insert mode",
        callback = function(evt)
          -- If we have n active nodes, n - 1 will still remain after a `unlink_current()` call.
          -- We unlink all of them by wrapping the calls in a loop.
          while true do
            if luasnip.session and luasnip.session.current_nodes[evt.buf] and not luasnip.session.jump_active then
              luasnip.unlink_current()
            else
              break
            end
          end
        end,
      })
    end,
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
    dependencies = {
      {
        "neovim/nvim-lspconfig",
        opts = {
          diagnostics = {
            virtual_text = false, -- Managed by `lsp_lines`
          },
        },
      },
    },
    opts = {},
    config = function(_, _)
      require("lsp_lines").setup()
      vim.diagnostic.config({ virtual_lines = false }) -- disable by default
    end,
  },
}
