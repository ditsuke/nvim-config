return {
  -- > Neovim plugin to improve the default vim.ui interfaces
  --
  -- Dressing can leverage multiple backends to override different vim.ui
  -- interfaces. By default, `telescope` overrides ui.select and dressing
  -- has its own component for ui.input
  "stevearc/dressing.nvim",
  opts = {
    -- TODO: consider using cursor just for codeactions
    -- Reference: https://github.com/stevearc/dressing.nvim#advanced-configuration
    select = {
      telescope = require("telescope.themes").get_cursor(),
    },
  },
}
