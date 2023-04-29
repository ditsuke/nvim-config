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
    event = "VeryLazy",
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
    "kevinhwang91/nvim-ufo",
    enabled = true,
    event = { "BufReadPost", "InsertEnter" },
    dependencies = { "kevinhwang91/promise-async" },
    opts = require("opts.ufo").config,
    init = require("opts.ufo").init,
    keys = {
      {
        "zR",
        function() require("ufo").openAllFolds() end,
        desc = "Open all folds",
      },
      {
        "zM",
        function() require("ufo").closeAllFolds() end,
        desc = "Close all folds",
      },
      {
        "zr",
        function() require("ufo").openFoldsExceptKinds() end,
        desc = "Fold less",
      },
      {
        "zm",
        function() require("ufo").closeFoldsWith() end,
        desc = "Fold more",
      },
      {
        "zp",
        function() require("ufo").peekFoldedLinesUnderCursor() end,
        desc = "Peek fold",
      },
    },
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
}
