return {
  -- >  Vim plugin for automatic time tracking and metrics generated from your programming activity.
  -- See: https://wakatime.com
  {
    "wakatime/vim-wakatime",
    event = "VeryLazy",
    init = function()
      -- Configure the Lua implementation ourselves before its automatic entrypoint
      -- can insert a second WakaTime component into our custom statusline.
      vim.g.loaded_wakatime = 1
    end,
    opts = { status_bar_enabled = false },
  },
}
