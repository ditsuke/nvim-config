-- A VS Code like winbar that uses nvim-navic in order to get LSP context from your language server.
--
-- FIXME: despite the fix from #35, `navic` still refuses to work
--  with barbecue.
--  After further investigation, I found that the bug is reproducible in my older
--  _lualine_ winbar, which begs the question if it's a navic bug or a bug
--  with lazyvim's handling of navic (particularly, how it attaches to a
--  LSP/buf).
return {
  "utilyre/barbecue.nvim", -- Wait for my PR to get merged
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons", -- optional dependency
  },
  opts = {
    -- The navic config that ships with Lazyvim already attaches
    -- for us, besides `barbecue/issue#35`
    attach_navic = false,
    -- Window number as leading section
    lead_custom_section = function(_, winnr) return string.format("  %d 󱋱 ", vim.api.nvim_win_get_number(winnr)) end,

    exclude_filetypes = {
      "DressingInput",
      "neo-tree",
      "toggleterm",
      "Trouble",
    },
  },
}
