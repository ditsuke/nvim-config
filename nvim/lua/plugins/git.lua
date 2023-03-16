return {
  {
    "ThePrimeagen/git-worktree.nvim",
    event = "VeryLazy",
    -- ! For some reason declaring this dependency overrides telescope.nvim setup in lazyvim core
    -- dependencies = { "nvim-telescope/telescope.nvim" },
    setup = function()
      require("git-worktree").setup()
      require("telescope").load_extension("git_worktree")
    end,
    keys = function()
      local telescope_worktree = require("telescope").extensions.git_worktree
      require("which-key").register({
        mode = { "n", "v" },
        -- TODO: clean up this which-key mess :(
        ["<leader>t"] = { name = "+telescope" },
        ["<leader>gw"] = { name = "git-worktree" },
      }, nil)

      return {
        {
          "<leader>gws",
          function() telescope_worktree.git_worktrees() end,
          desc = "[s]witch",
        },
        {
          "<leader>gwa",
          function() telescope_worktree.create_git_worktree() end,
          desc = "[a]dd",
        },
      }
    end,
  },
}
