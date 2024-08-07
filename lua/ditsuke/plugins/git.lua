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

  -- Create and switch worktrees with a telescope-driven UI.
  --
  -- STATUS(2023-04-08): I like it, but I've barely ever used it.
  -- I should consider axing it if it doesn't become a part of my workflow.
  {
    "ThePrimeagen/git-worktree.nvim",
    event = "VeryLazy",
    -- ! For some reason declaring this dependency overrides telescope.nvim setup in lazyvim core
    -- dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("git-worktree").setup()
      require("telescope").load_extension("git_worktree")
    end,
    keys = function()
      if require("lazyvim.util").has("which-key") then
        require("which-key").register({
          mode = { "n", "v" },
          -- TODO: clean up this which-key mess :(
          ["<leader>t"] = { name = "+telescope" },
          ["<leader>gw"] = { name = "git-worktree" },
        }, nil)
      end

      return {
        {
          "<leader>gws",
          function() require("telescope").extensions.git_worktree.git_worktrees() end,
          desc = "[s]witch",
        },
        {
          "<leader>gwa",
          function() require("telescope").extensions.git_worktree.create_git_worktree() end,
          desc = "[a]dd",
        },
      }
    end,
  },

  -- > Single tabpage interface for easily cycling through diffs for all modified files for any git rev.
  -- Use hints:
  -- - `:DiffviewOpen` to open the diff view
  -- - `:DiffviewFileHistory` to open the file history view
  {
    "sindrets/diffview.nvim",
  },

  -- > A lua neovim plugin to generate shareable file permalinks (with line ranges) for several git web frontend
  -- > hosts. Inspired by tpope/vim-fugitive's :GBrowse
  {
    "linrongbin16/gitlinker.nvim",
    opts = true,
  },
}
