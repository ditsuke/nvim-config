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
    event = "BufReadPre",
    opts = {
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
    config = true,
  },

  -- Escape from insert mode with `jk` or `jj`, without delay or lag when typing
  {
    "max397574/better-escape.nvim",
    opts = {
      mapping = { "jk", "jj" },
      timeout = 200,
      clear_empty_lines = true,
      keys = "<Esc>",
    },
  },

  -- >  Treesitter based structural search and replace plugin for Neovim.
  -- Ref: https://www.jetbrains.com/help/idea/structural-search-and-replace.html
  {
    "cshuaimin/ssr.nvim",
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
}
