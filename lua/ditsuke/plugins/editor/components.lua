return {
  {
    -- Jump between files and terminals
    "ThePrimeagen/harpoon",
    event = "VeryLazy",
    keys = {
      { "<leader>a", function() require("harpoon.mark").add_file() end, desc = "Harpoon: [m]ark file" },
      { "<C-A>", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon: toggle quick menu" },
      { "<Tab>", function() require("harpoon.ui").nav_next() end, desc = "Harpoon: Nav next" },
      { "<S-Tab>", function() require("harpoon.ui").nav_prev() end, desc = "Harpoon: Nav prev" },
    },
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
    keys = { { "<leader>z", function() require("zen-mode").toggle() end, desc = "Toggle [z]enmode"} },
  },
  {
    -- Diagnostics with virtual text. Does multiline well
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    event = "BufReadPost",
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
