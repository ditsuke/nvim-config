return {
  {
    "folke/persistence.nvim",
    opts = {
      -- Include globals to persist special things, such as pinned buffers
      options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals" },
    },
  },
}
