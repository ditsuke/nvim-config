-- Disable this configuration set
if true then
  return {}
end

-- NOTE: This configuration breaks Neoconf, plus `neoconf-neovim-configuration` is barely
-- useful as-is. I plan to develop a declarative configuration plugin of my own, so I'll retain this
-- file as a reminder of sorts.
return {
  ---@type LazySpec[]
  {
    "folke/neoconf.nvim",
    event = "VeryLazy",
    cmd = "Neoconf",
    priority = 1000,
    config = function(opts)
      print("loaded neoconf")
      require("neoconf").setup(opts)
    end,
    dependencies = {
      {
        "https://git.jacky.wtf/neovim/neoconf-neovim-configuration",
        priority = 1,
        config = function() require("neoconf-neovim-options").setup() end,
      },
    },
  },
}
