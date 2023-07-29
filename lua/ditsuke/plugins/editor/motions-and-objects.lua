return {
  {
    -- _Better_ f/t motions for `leap.nvim`
    -- TODO: remove in favour of `flash.nvim` (which is already the default and enabled at the time of writing)
    "ggandor/flit.nvim",
    enabled = false,
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
