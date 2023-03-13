local CMD_NO_SESSION = "NoSession"

return {
  {
    "folke/persistence.nvim",
    lazy = false,
    event = "VimEnter",
    init = function()
      local does_persist, persistence = pcall(require, "persistence")
      if not does_persist then
        return
      end

      vim.api.nvim_create_user_command(CMD_NO_SESSION, function(_) end, {}) -- Is the requirement misdocumented in neodev?
      vim.api.nvim_create_autocmd("User", {
        pattern = { "LazyDone" },
        group = vim.api.nvim_create_augroup("LoadSession", { clear = true }),
        callback = function()
          if vim.tbl_contains(vim.v.argv, "+" .. CMD_NO_SESSION) then
            require("persistence").stop()
            return
          end
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
          vim.api.nvim_del_augroup_by_name("LoadSession")
          vim.api.nvim_del_user_command(CMD_NO_SESSION)
        end,
      })
    end,
    opts = {
      -- Include globals to persist special things, such as pinned buffers
      options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals" },
    },
  },
}
