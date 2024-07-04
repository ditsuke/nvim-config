return {

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
    enabled = false,
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
    event = "LspAttach",
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
  {
    -- >  LSP diagnostics in virtual text at the top right of your screen
    -- NOTE: Promising but not quite there yet. Last I updated this the plugin worked but the generated
    -- text has too big a right offset to be very visible. This is configurable but I don't see
    -- why it should be broken by default.
    "dgagn/diagflow.nvim",
    event = "LspAttach",
    config = true,
  },

  -- > A pretty window for previewing, navigating and editing your LSP locations.
  {
    "DNLHC/glance.nvim",
    dependencies = {
      {
        "neovim/nvim-lspconfig",
        -- NOTE: This is the lazyvim way of customizing lsp keymaps
        -- Ref: https://github.com/lazyVim/lazyVim/issues/93
        opts = function(_, _)
          local Keys = require("lazyvim.plugins.lsp.keymaps").get()
          vim.list_extend(Keys, {
            {
              "gd",
              function() vim.cmd("Glance definitions") end,
              desc = "Goto Definition",
              has = "definition",
            },
            {
              "gr",
              function() vim.cmd("Glance references") end,
              desc = "References",
              nowait = true,
            },
            {
              "gI",
              function() vim.cmd("Glance implementations") end,
              desc = "Goto Implementation",
            },
            {
              "gy",
              function() vim.cmd("Glance type_definitions") end,
              desc = "Goto T[y]pe Definition",
            },
          })
        end,
      },
    },
    config = true,
  },
}
