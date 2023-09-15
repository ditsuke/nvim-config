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

  -- > Dim inactive windows in Neovim using window-local highlight namespaces.
  {
    "levouh/tint.nvim",
    -- enabled = false,
    dependencies = { "lualine.nvim" },
    event = "BufWinEnter",
    opts = {
      highlight_ignore_patterns = { "WinSeparator", "Status.*", "Lualine.*" },
    },
    config = function(_, opts)
      require("tint").setup(opts)
      vim.api.nvim_create_autocmd({ "ModeChanged" }, {
        callback = function() require("tint").refresh() end,
      })
    end,
  },
  -- {
  --   "nvim-zh/colorful-winsep.nvim",
  --   config = true,
  --   event = { "WinNew" },
  -- },
}
