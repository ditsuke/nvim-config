return {
  {
    -- _Better_ f/t motions for `leap.nvim`
    "ggandor/flit.nvim",
    opts = {
      multiline = false,
    },
  },
  {
    -- Surrounds
    -- TODO: evaluate mini.surround
    "kylechui/nvim-surround",
    opts = {},
    event = "BufRead",
  },
}
