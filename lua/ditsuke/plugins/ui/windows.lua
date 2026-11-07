return {
  -- > Automatically expand width of the current window.
  -- > Maximizes and restore it. And all this with nice animations!
  {
    "anuvyklack/windows.nvim",
    -- enabled = false,
    event = "BufWinEnter",
    dependencies = {
      "anuvyklack/middleclass",
      -- >  Create animations in Neovim.
      -- This is an (optional) dependency for windows.nvim, enabling animations.
      -- "anuvyklack/animation.nvim",
    },
    keys = {
      { "<C-W>M", function() require("windows.commands").maximize() end, desc = "[M]aximize current window" },
    },
    config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require("windows").setup()
    end,
  },

  -- {
  --   "nvim-zh/colorful-winsep.nvim",
  --   config = true,
  --   event = { "WinNew" },
  -- },
}
