return {
  { "NMAC427/guess-indent.nvim", event = "BufReadPre", opts = { auto_cmd = true } },
  {
    -- Smooth-scrolling!
    "psliwka/vim-smoothie",
    enabled = false,
    event = "BufReadPost",
    keys = {
      { "<C-D>", '<Cmd>call smoothie#do("<C-D>zz")<CR>' },
      { "<C-U>", '<Cmd>call smoothie#do("<C-U>zz")<CR>' },
      { "n", '<Cmd>call smoothie#do("nzz")<CR>' },
      { "N", '<Cmd>call smoothie#do("Nzz")<CR>' },
      { "gg", '<Cmd>call smoothie#do("gg")<CR>' },
      { "G", '<Cmd>call smoothie#do("G")<CR>' },
    },
  },
  {
    -- Only highlight cursorline of the active window
    -- Makes it easier to tell what window is active in the
    -- Absence of a prominent cursor (such as with lighter-colored themes)
    "tummetott/reticle.nvim",
    -- enabled = false,
    event = "BufReadPre",
    opts = {
      on_startup = {
        cursorline = true,
      },
      always = {
        cursorline = {
          "neo-tree", -- reticle messes up with Neo-tree cursorline in search mode
        },
      },
    },
  },
  {
    "echasnovski/mini.bufremove",
    keys = {
      -- <C-F4>
      { "<F28>", function() require("mini.bufremove").delete(0, false) end, desc = "Delete buffer" },
    },
  },
  {
    -- Jump to previous/next *buffer* in the jumplist with <C-p> & <C-n>
    "kwkarlwang/bufjump.nvim",
    config = true,
  },
  {
    "echasnovski/mini.indentscope",
    opts = function(_, og)
      local overrides = {
        draw = {
          animation = require("mini.indentscope").gen_animation.none(),
          delay = 50,
        },
      }

      return vim.tbl_deep_extend("force", og, overrides)
    end,
  },
  {
    -- draw `:h colorcolumn` with a virtual text + a character
    "lukas-reineke/virt-column.nvim",
    enabled = false,
    config = true,
  },

  -- Escape from insert mode with `jk` or `jj`, without delay or lag when typing
  {
    "max397574/better-escape.nvim",
    opts = {
      default_mappings = false,
      mappings = {
        i = {
          j = {
            k = "<Esc>",
          },
        },
        t = {
          j = {
            k = function()
              -- bsKeys + feedkeys works great with toggleterm and lazyterm + shell,
              -- doesn't work with lazyterm + tui (f. ex. <leader>gg lazygit)
              local bsKeys = vim.api.nvim_replace_termcodes("<BS><Esc><Esc>", true, false, true)
              vim.api.nvim_feedkeys(bsKeys, "n", true)

              -- FIXME: keys + return works in all cases, but moves the cursor to bottom right for some reason?
              -- local keys = vim.api.nvim_replace_termcodes("<Esc><Esc>", true, false, true)
              -- return keys
            end,
          },
        },
      },
      timeout = 200,
      clear_empty_lines = true,
    },
  },

  -- >  Treesitter based structural search and replace plugin for Neovim.
  -- Ref: https://www.jetbrains.com/help/idea/structural-search-and-replace.html
  {
    "cshuaimin/ssr.nvim",
    enabled = false,
    event = "BufReadPre",
    keys = {
      {
        "<leader>sR",
        function() require("ssr").open() end,
        mode = { "n", "x" },
        desc = "Structural Replace",
      },
    },
  },

  -- > A neovim autopair plugin designed to have all the features that an autopair plugin needs.
  -- TODO: Re-evaluate this plugin at a later stage (30-09-2023)
  -- {
  --   "altermo/ultimate-autopair.nvim",
  --   enabled = true,
  --   dependencies = {
  --     {
  --       "windwp/nvim-autopairs",
  --       config = function()
  --         local npairs = require("nvim-autopairs")
  --         npairs.setup({})
  --         for _, i in ipairs(npairs.config.rules) do
  --           i.key_map = nil
  --         end
  --       end,
  --     },
  --   },
  --   event = { "InsertEnter", "CmdlineEnter" },
  --   branch = "development",
  --   -- branch = "v0.6",
  --   config = true,
  -- },
  -- >  autopairs for neovim written by lua
  {
    "windwp/nvim-autopairs",
    config = true,
  },

  -- > Neovim treesitter plugin for setting the commentstring based on the cursor location in a file.
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    opts = {
      config = {
        -- Custom commentstring for C++ files, since default is block comment style (hard to work with when nested)
        cpp = "// %s",
      },
    },
  },

  -- >  Navigate your code with search labels, enhanced character motions and Treesitter integration.
  -- (lazyvim default)
  {
    "folke/flash.nvim",
    config = {
      modes = {
        search = {
          -- I found the search mode to be a bit too intrusive
          enabled = false,
        },
      },
    },
  },

  -- > Simple plugin implements smart-tab feature from Helix 23.10.
  --
  -- > Smart Tab is a new feature bound to the tab key in the default keymap. When you press tab and the line to the left
  -- > of the cursor isn't all whitespace, the cursor will jump to the end of the syntax tree's parent node. This is
  -- > useful in languages like Nix for adding semicolons at the end of an attribute set or jumping to the end of a block
  -- > in a C-like language
  --
  -- TODO: try this out and see if it's better than `nvim-treesitter`
  {
    "boltlessengineer/smart-tab.nvim",
    config = true,
  },

  {
    "Wansmer/treesj",
    keys = { "<space>m", "<space>j", "<space>s" },
    config = {},
  },
}
