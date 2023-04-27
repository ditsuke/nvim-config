local disable_on_large_buffers = function(_, bufnr)
  local TS_MAX_LINE = 2000
  return vim.api.nvim_buf_line_count(bufnr) > TS_MAX_LINE
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = true,
    init = nil,
    dependencies = {
      { "nvim-treesitter-textobjects", enabled = false, init = nil }, -- Disable textobjects, I'm not using it anyways
      "nvim-treesitter/playground",
      -- highlight same-name identifiers with the same color
      "David-Kunz/markid",
      "HiPhish/nvim-ts-rainbow2",
      "nvim-treesitter/nvim-treesitter-refactor",
      -- Show code context (function, etc) on top while navigating ala context.vim
      "nvim-treesitter/nvim-treesitter-context",
      "theHamsta/nvim-dap-virtual-text",
      "windwp/nvim-ts-autotag",
      "andymass/vim-matchup",
    },
    opts = {
      auto_install = true,
      highlight = {
        disable = disable_on_large_buffers,
      },
      markid = {
        enable = true,
        disable = disable_on_large_buffers,
      },
      rainbow = {
        enable = true,
        query = "rainbow-parens",
        max_file_lines = 2000,
      },
      refactor = {
        enable = true,
        disable = disable_on_large_buffers,
        highlight_definitions = {
          enable = true,
          clear_on_cursor_move = false,
        },
        highlight_current_scope = { enable = true },
        -- TODO: consider using goto-definition etc
      },
      autotag = {
        enable = true,
        disable = disable_on_large_buffers,
      },
      matchup = {
        enable = true,
        disable = disable_on_large_buffers,
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
    enabled = false,
    name = "better-comment.nvim",
    config = function(_, opts) require("better-comment").Setup(opts) end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    config = true,
  },
  {
    -- IncRename, like IncSearch but for LSP renaming
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    config = true,
  },
}
