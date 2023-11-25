return {
  -- > A minimalistic .env support for Neovim
  --
  -- This plugin does three things:
  -- - Autoloads .env files when you open a buffer
  -- - Adds `:DotenvLoad` command to load .env files manually
  -- - Adds `:DotenvGet` command to get a value from a .env file
  "ellisonleao/dotenv.nvim",
  opts = {
    enable_on_load = true,
    verbose = false, -- Show errors if can't load/not found.
  },
  init = function()
    -- Add {}
    vim.filetype.add({
      pattern = {
        ["[%w_]*%.env"] = "dotenv",
        ["%.env%.[%w_]*"] = "dotenv",
      },
      filename = {
        [".env"] = "dotenv",
      },
    })
  end,
}
