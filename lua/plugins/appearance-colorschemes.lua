return {
  {
    "folke/tokyonight.nvim",
    event = "VeryLazy",
  },
  {
    "jesseleite/nvim-noirbuddy",
    event = "VeryLazy",
    dependencies = {
      "tjdevries/colorbuddy.nvim",
      branch = "dev",
    },
  },
  {
    "nyoom-engineering/oxocarbon.nvim",
    event = "VeryLazy",
  },
  {
    -- So cool!
    "bluz71/vim-moonfly-colors",
    event = "VeryLazy",
  },
  {
    "bluz71/vim-nightfly-colors",
    event = "VeryLazy",
  },
  {
    "Everblush/nvim",
    event = "VeryLazy",
  },
  {
    "rockerBOO/boo-colorscheme-nvim",
    event = "VeryLazy",
  },
  {
    "phha/zenburn.nvim",
    event = "VeryLazy",
  },
  {
    "JoosepAlviste/palenightfall.nvim",
    event = "VeryLazy",
  },
  {
    "yonlu/omni.vim",
    event = "VeryLazy",
  },
  {
    "lighthaus-theme/vim-lighthaus",
    event = "VeryLazy",
  },
  {
    "Abstract-IDE/Abstract-cs",
    event = "VeryLazy",
  },
  {
    "Mofiqul/dracula.nvim",
    event = "VeryLazy",
  },
  {
    "mcchrish/zenbones.nvim",
    event = "VeryLazy",
    dependencies = {
      "rktjmp/lush.nvim",
    },
  },
  {
    "LunarVim/horizon.nvim",
    event = "VeryLazy",
  },
  {
    "LunarVim/synthwave84.nvim",
    event = "VeryLazy",
  },
  {
    "katawful/kat.nvim",
    event = "VeryLazy",
  },
  {
    "catppuccin/nvim",
    event = "VeryLazy",
    name = "catppuccin",
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    event = "VeryLazy",
  },
  {
    "hachy/eva01.vim",
    event = "VeryLazy",
  },
  {
    "igorgue/danger",
    event = "VeryLazy",
  },
  {
    "rebelot/kanagawa.nvim",
    event = "VeryLazy",
  },
  {
    "arturgoms/moonbow.nvim",
    event = "VeryLazy",
  },
  {
    "ellisonleao/gruvbox.nvim",
    event = "VeryLazy",
    opts = {
      palette_overrides = {},
    },
    {
      -- Tons of awesome color schemes in base16. Really nice!
      "RRethy/nvim-base16",
      event = "VeryLazy",
    },
  },
  {
    "ray-x/starry.nvim",
    event = "VeryLazy",
  },
  {
    "ray-x/aurora",
    event = "VeryLazy",
  },
  -- Effortlessly sync the terminal background with Neovim.
  -- As a side effect, get effortless transparency across color schemes!
  { "typicode/bg.nvim", lazy = false, cond = function() return os.getenv("NVIM_COLORSYNC") == nil end },
  -- Configure LazyVim to load oxocarbon
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
}
