return {
  -- "karb94/neoscroll.nvim",
  "psliwka/vim-smoothie",
  event = "BufReadPost",
  keys = {
    { "<C-D>", '<Cmd>call smoothie#do("<C-D>zz")<CR>' },
    { "<C-U>", '<Cmd>call smoothie#do("<C-U>zz")<CR>' },
    { "n", '<Cmd>call smoothie#do("nzz")<CR>' },
    { "N", '<Cmd>call smoothie#do("Nzz")<CR>' },
  },
}
