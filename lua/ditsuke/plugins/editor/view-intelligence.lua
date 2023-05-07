return {
  -- > ✅ Highlight, list and search todo comments in your projects
  {
    "folke/todo-comments.nvim",
    enabled = true,
    opts = {
      keywords = {
        -- QUESTION = { icon = "?", color = "warning", alt = { "Q" } },
      },
    },
  },

  -- > Better comments helps you to organize your comments with highlights and virtual text.
  {
    "Djancyp/better-comments.nvim",
    enabled = false,
    name = "better-comment.nvim",
    config = function(_, opts) require("better-comment").Setup(opts) end,
  },

  -- > A high-performance color highlighter for Neovim which has no external dependencies! Written in performant Luajit.
  {
    "NvChad/nvim-colorizer.lua",
    config = true,
  },

  -- > Incremental LSP renaming based on Neovim's command-preview feature.
  {
    "smjonas/inc-rename.nvim",
    event = "VeryLazy",
    dependencies = {
      "noice.nvim",
      opts = {
        presets = { inc_rename = true },
      },
    },
    cmd = "IncRename",
    config = true,
  },
}
