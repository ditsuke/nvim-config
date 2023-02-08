return {
  -- Show code context (function, etc) on top while navigating ala context.vim
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPost",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("treesitter-context").setup()
    end,
  },
}
