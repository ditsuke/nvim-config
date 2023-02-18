return {
  { "NMAC427/guess-indent.nvim", event = "BufReadPost", opts = {} },
  {
    -- Smooth-scrolling!
    "psliwka/vim-smoothie",
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
    opts = {},
  },
}
