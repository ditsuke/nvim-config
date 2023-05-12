return {
  -- File tree
  "nvim-neo-tree/neo-tree.nvim",
  branch = "main", -- override until fuzzy_finder_mappings is in 2.x
  opts = function(_, og)
    local icons = require("ditsuke.utils.icons")
    local overrides = {
      -- auto_clean_after_session_restore = true,
      close_if_last_window = true,
      window = {
        width = 30,
        position = "right",
        mappings = {
          ["/"] = "noop",
        },
        fuzzy_finder_mappings = {
          ["<C-j>"] = "move_cursor_down",
          ["<C-k>"] = "move_cursor_up",
        },
      },
      default_component_configs = {
        indent = { padding = 0, indent_size = 1 },
        icon = {
          folder_closed = icons.states.folder_closed,
          folder_open = icons.states.folder_open,
          folder_empty = icons.states.folder_empty,
          default = icons.misc.default_file,
        },
        modified = { symbol = icons.states.file_modified },
        git_status = {
          symbols = {
            added = icons.git.added,
            deleted = icons.git.removed,
            modified = icons.git.modified,
            renamed = icons.git.renamed,
            untracked = icons.git.untracked,
            ignored = icons.git.ignored,
            unstaged = icons.git.unstaged,
            staged = icons.git.staged,
            conflict = icons.git.conflict,
          },
        },
      },
    }
    return vim.tbl_deep_extend("force", og, overrides)
  end,
  keys = {
    {
      "<leader>e",
      function() require("neo-tree.command").execute({ focus = true }) end,
      desc = "Focus Neotree",
    },
  },
}
