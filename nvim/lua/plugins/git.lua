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
      print("returning keys")
      -- if require("lazyvim.util").has("which-key.nvim") then
      require("which-key").register({
        mode = { "n", "v" },
        ["<leader>t"] = { name = "+telescope" },
        ["<leader>tw"] = { name = "git-worktree" },
      }, nil)
      -- end

      return {
        {
          "<leader>tws",
          function()
            telescope_worktree.git_worktrees()
          end,
          desc = "[s]witch",
        },
        {
          "<leader>twc",
          function()
            telescope_worktree.create_git_worktree()
          end,
          desc = "[c]reate",
        },
      }
    end,
  },
}
