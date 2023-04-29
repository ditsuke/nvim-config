local M = {}

M.config = function(_, opts)
  local actions = require("telescope.actions")

  local fzf_opts = {
    fuzzy = true, -- false will only do exact matching
    override_generic_sorter = true, -- override the generic sorter
    override_file_sorter = true, -- override the file sorter
    case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    -- the default case_mode is "smart_case"
  }

  local frecency_opts = {
    db_root = "~/.local/share/nvim",
  }

  local undo_opts = {
    use_delta = true,
    side_by_side = true,
    layout_strategy = "vertical",
    layout_config = {
      preview_height = 0.8,
    },
  }

  local overrides = {
    extensions = {
      fzf = fzf_opts,
      frecency = frecency_opts,
      undo = undo_opts,
    },
    pickers = {
      lsp_dynamic_workspace_symbols = {
        -- Manually set sorter, for some reason not picked up automatically
        -- Ref: https://github.com/nvim-telescope/telescope.nvim/issues/2104#issuecomment-1223790155
        sorter = require("telescope").extensions.fzf.native_fzf_sorter(fzf_opts),
      },
    },
    -- Use the `ivy` theme, inspired by Emacs Ivy!
    defaults = require("telescope.themes").get_ivy({
      mappings = {
        i = {
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
          ["<C-J>"] = actions.move_selection_next,
          ["<C-K>"] = actions.move_selection_previous,
        },
      },
    }),
  }

  return vim.tbl_deep_extend("force", opts, overrides)
end

M.keys = {
  { "<leader>bs", function() require("telescope.builtin").buffers() end, desc = "[s]earch" },
  { "<F1>", function() require("telescope.builtin").help_tags() end, desc = "Search :help" },
  {
    "<C-`>",
    function() require("telescope.builtin").colorscheme({ enable_preview = true }) end,
    desc = "Preview and switch colorschemes/themes",
  },
  {
    "<leader>st",
    function() require("telescope").extensions.termfinder.find({}) end,
    desc = "[t]erminals",
  },
  {
    "<leader>sS",
    function()
      require("lazyvim.util").telescope("lsp_dynamic_workspace_symbols", {
        symbols = {
          "Class",
          "Function",
          "Method",
          "Constructor",
          "Interface",
          "Module",
          "Struct",
          "Trait",
          "Field",
        },
      })()
    end,
  },
  {
    "<leader>su",
    function() require("telescope").extensions.undo.undo() end,
    desc = "[u]ndo tree",
  },
  {
    "<leader>fr",
    function()
      require("telescope").extensions.frecency.frecency({
        workspace = "CWD",
      })
    end,
    desc = "[r]ecent",
  },
  {
    "<leader>tr",
    function() require("telescope.builtin").resume() end,
    desc = "[r]esume",
  },
}

return M
