return {
  -- Show code context (function, etc) on top while navigating ala context.vim
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/playground",
      "David-Kunz/markid",
      "HiPhish/nvim-ts-rainbow2",
      "nvim-treesitter/nvim-treesitter-refactor",
      "nvim-treesitter/nvim-treesitter-context",
      "theHamsta/nvim-dap-virtual-text",
      "windwp/nvim-ts-autotag",
      "andymass/vim-matchup",
    },
    opts = {
      auto_install = true,
      markid = {
        enable = false, -- Perf impact high on big (5000LOC :3) files -- I'll maybe have it configurable with neoconf later
      },
      rainbow = {
        enable = true,
        query = "rainbow-parens",
        max_file_lines = 3000,
      },
      refactor = {
        enable = true,
        clear_on_cursor_move = false,
        highlight_definitions = { enable = true },
      },
      autotag = {
        enable = true,
      },
      matchup = {
        enable = true,
      },
    },
    keys = {
      { "<leader>ux", "<Cmd>TSHighlightCapturesUnderCursor<CR>", desc = "Show highlight groups" },
    },
  },
  {
    "folke/todo-comments.nvim",
    enabled = false,
    opts = {
      keywords = {
        QUESTION = { icon = "?", color = "warning", alt = { "Q" } },
      },
    },
  },
  {
    "Djancyp/better-comments.nvim",
    name = "better-comment.nvim",
    config = function(_, opts)
      require("better-comment").Setup(opts)
    end,
  },
}
