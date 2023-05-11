-- Extensible fuzzy searcher for files, buffers, and virtually everything else
local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && \
          cmake --build build --config Release && \
          cmake --install build --prefix build",
      config = function() require("telescope").load_extension("fzf") end,
    },
    {
      "nvim-telescope/telescope-frecency.nvim",
      dependencies = { { "kkharji/sqlite.lua" } },
      config = function() require("telescope").load_extension("frecency") end,
    },
    {
      -- Find terminals 👿
      "tknightz/telescope-termfinder.nvim",
      config = function() require("telescope").load_extension("termfinder") end,
    },
    {
      "debugloop/telescope-undo.nvim",
      config = function() require("telescope").load_extension("undo") end,
    },
    {
      -- > `telescope-file-browser.nvim` is a file browser extension for telescope.nvim.
      -- > It supports synchronized creation, deletion, renaming, and moving of files and folders powered by telescope.nvim and plenary.nvim.
      "nvim-telescope/telescope-file-browser.nvim",
      config = function() require("telescope").load_extension("file_browser") end,
    },
  },
  keys = {
    {
      "<leader>fF",
      function() require("telescope.builtin").find_files({ hidden = true, no_ignore = true }) end,
      desc = "[f]ind [f]iles",
    },
    {
      "<leader>fb",
      -- stylua: ignore
      function() require("telescope").extensions.file_browser.file_browser({ hidden = true, no_ignore = true, path = "%:p:h" }) end,
    },
    {
      "<leader>o",
      -- stylua: ignore
      function() require("telescope").extensions.file_browser.file_browser({ hidden = true, no_ignore = true, path = "%:p:h" }) end,
    },
    { "<leader>bs", function() require("telescope.builtin").buffers({ sort_mru = true }) end, desc = "[s]earch" },
    { "<leader>,", function() require("telescope.builtin").buffers({ sort_mru = true }) end, desc = "search buffers" },
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
      "<M-BSlash>",
      function() require("telescope").extensions.termfinder.find({}) end,
      desc = "find terminals",
      mode = { "t", "i", "n" },
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
  },
}

M.opts = function(_, opts)
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

  local file_browser_opts = {
    theme = "ivy",
    -- disables netrw and use telescope-file-browser in its place
    hijack_netrw = true,
    mappings = {
      ["i"] = {
        -- your custom insert mode mappings
      },
      ["n"] = {
        -- your custom normal mode mappings
      },
    },
  }

  local overrides = {
    extensions = {
      fzf = fzf_opts,
      frecency = frecency_opts,
      undo = undo_opts,
      file_browser = file_browser_opts,
    },
    pickers = {
      lsp_dynamic_workspace_symbols = {
        -- Manually set sorter, for some reason not picked up automatically
        -- Ref: https://github.com/nvim-telescope/telescope.nvim/issues/2104#issuecomment-1223790155
        sorter = require("telescope").extensions.fzf.native_fzf_sorter(fzf_opts),
      },
    },
    -- Use the `ivy` theme, inspired by Emacs Ivy!
    -- Also disable previews and reduce height
    defaults = require("telescope.themes").get_ivy({
      preview = { hide_on_startup = true }, -- An experiment (I might enable just for grep/livegrep)
      layout_config = {
        height = 15,
      },
      mappings = {
        i = {
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
          ["<C-J>"] = actions.move_selection_next,
          ["<C-K>"] = actions.move_selection_previous,
          ["<M-p>"] = require("telescope.actions.layout").toggle_preview,
        },
      },
    }),
  }

  return vim.tbl_deep_extend("force", opts, overrides)
end

return M
