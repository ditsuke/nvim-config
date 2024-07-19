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

  -- >  Show lsp diagnostics based on mouse position
  -- FIXME: not working atm:
  -- - No popup on hover. It only appears on clicking (with mouse=a ofcourse)
  -- - The popup does not close on moving/mouseleave
  -- UPDATE:
  -- - I have verified that it DOES NOT work with stock LazyVim either, so this plugin is almost certainly broken,
  --  at least with nvim nightly as of 2021-11-19
  {
    "soulis-1256/hoverhints.nvim",
    event = "BufReadPost",
    config = true,
    enabled = false,
  },

  -- > Use popup windows to navigate files/buffer and to contain shells/TUIs
  --
  -- This plugin lets you open ephemeral popups with a buffer or terminal in them. Useful
  -- for 'detours', where you're perhaps going through files or following a chain of functions.
  -- It does allow for then opening a permanent window with the same buffer, which is nice.
  -- FIXME: this does not work at all atm, at least not with nvim 0.9.4 as of 2023-11-19
  -- UPDATE:
  -- - I have verified that it works with stock LazyVim, so it's probably something in my config, or an interaction with another plugin
  --  that's causing this to not work. Some debugging is in order. Some guesses:
  --  - `windows.nvim`
  {
    "carbon-steel/detour.nvim",
    keys = {
      { "<c-w><enter>", function() require("detour").Detour() end, desc = "Open detour float" },
    },
    config = function(_, _)
      -- TODO: get rid of this keymap (this is just for experimentation)
      -- A keymap for selecting a terminal buffer to open in a popup
      vim.keymap.set("n", "<leader>tt", function()
        require("detour").Detour() -- Open a detour popup

        -- Switch to a blank buffer to prevent any accidental changes.
        vim.cmd.enew()
        vim.bo.bufhidden = "delete"

        require("telescope.builtin").buffers({}) -- Open telescope prompt
        vim.api.nvim_feedkeys("term", "n", true) -- popuplate prompt with "term"
      end)
    end,
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
    ---@type
    opts = {
      hooks = {
        -- If there is only one result, jump to it directly
        before_open = function(results, open, jump, _method)
          if #results == 1 then
            jump(results[1])
          else
            open(results)
          end
        end,
      },
    },
  },
}
