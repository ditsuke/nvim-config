return {
  {
    -- Neogit -- an experimental addition, not yet a part of my workflow
    "TimUntersberger/neogit",
    event = "VeryLazy",
    dependencies = {
      "plenary.nvim",
    },
    config = true,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true, -- Inline blame for current line w/ virt-text
    },
  },

  -- >  A plugin to visualise and resolve merge conflicts in neovim
  -- Bindings (default):
  -- > This plugin offers default buffer local mappings inside conflicted files. This is primarily because applying these mappings only to relevant buffers is impossible through global mappings. A user can however disable these by setting default_mappings = false anyway and create global mappings as shown below. The default mappings are:
  -- > - co — choose ours
  -- > - ct — choose theirs
  -- > - cb — choose both
  -- > - c0 — choose none
  -- > - ]x — move to previous conflict
  -- > - [x — move to next conflict
  {
    "akinsho/git-conflict.nvim",
    event = "VeryLazy",
    version = "*",
    config = true,
  },

  -- > Single tabpage interface for easily cycling through diffs for all modified files for any git rev.
  -- Use hints:
  -- - `:DiffviewOpen` to open the diff view
  -- - `:DiffviewFileHistory` to open the file history view
  {
    "dlyongemallo/diffview-plus.nvim",
    main = "diffview",
    opts = {},
  },

  -- > A lua neovim plugin to generate shareable file permalinks (with line ranges) for several git web frontend
  -- > hosts. Inspired by tpope/vim-fugitive's :GBrowse
  {
    "linrongbin16/gitlinker.nvim",
    opts = true,
  },
}
