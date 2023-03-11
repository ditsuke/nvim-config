-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.clipboard = "" -- **Do not** sync with the system clipboard
opt.mouse = "v" -- Disable mouse support by default

-- Make window title indicative of our cwd
-- Loaded before normal autocmds (./autocmds) because we leverage the `VimEnter` here.
vim.api.nvim_create_autocmd({ "DirChanged", "VimEnter" }, {
  group = vim.api.nvim_create_augroup("update_window_title", { clear = true }),
  callback = function()
    local scope = vim.v.event.scope
    if scope == nil or scope == "global" then
      require("config.shared").setTitle()
    end
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = { "LazyVimStarted" },
  group = vim.api.nvim_create_augroup("LoadSession", { clear = true }),
  callback = function()
    local does_persist, persistence = pcall(require, "persistence")
    if does_persist then
      -- vim.loop.timer_start(timer, 1, 0, function()
      --   vim.schedule(function()
      --     persistence.load()
      --     print("done loadin since 69")
      --   end)
      -- end)

      -- Appanrently I don't even have to delay it, just send it to the event loop
      -- If I load it right here, the session loads fine but buffers don't have treesitter etc
      -- To me this indicates that Lazyvim's `started` event is fired while plugins are
      -- still in a queue sent to the uv event loop, might be unwanted behavioe on lazy.nvim's end
      vim.schedule(persistence.load)
      print("done sleepin' since 69")
    end
    vim.api.nvim_del_augroup_by_name("LoadSession")
  end,
})
