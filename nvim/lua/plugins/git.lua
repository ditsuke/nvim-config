return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true, -- Inline blame for current line w/ virt-text
    },
  },
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
      require("which-key").register({
        mode = { "n", "v" },
        -- TODO: clean up this which-key mess :(
        ["<leader>t"] = { name = "+telescope" },
        ["<leader>gw"] = { name = "git-worktree" },
      }, nil)

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
}
