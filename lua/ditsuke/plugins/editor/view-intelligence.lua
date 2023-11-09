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
    event = "BufReadPre",
    opts = {
      filetypes = {
        "*",
        "!lazy",
      },
    },
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

  -- >  An extremely lightweight plugin (~ 120loc) that hightlights ranges you have entered in commandline.
  {
    "winston0410/range-highlight.nvim",
    event = "VeryLazy",
    dependencies = {
      "winston0410/cmd-parser.nvim",
    },
    config = true,
  },

  -- > Cursor line number mode indicator.
  --
  -- > A small Neovim plugin that changes the foreground color of the CursorLineNr highlight based on the current Vim mode.
  {
    "mawkler/modicator.nvim",
    event = "BufReadPost",
    config = true,
  },
}
