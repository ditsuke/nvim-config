return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "VimEnter",
    config = function()
      -- TODO: figure out why tf the LSP complains here
      vim.defer_fn(function()
        require("copilot").setup()
      end, 100)
    end,
  },
  -- TODO: try hooking this up
  {
    "zbirenbaum/copilot-cmp",
  },
}
