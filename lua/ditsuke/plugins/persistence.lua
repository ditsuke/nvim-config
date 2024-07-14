local CMD_NO_SESSION = "NoSession"

return {
  {
    "folke/persistence.nvim",
    lazy = false,
    event = "VimEnter",
    opts = {},
    config = function(_, opts)
      local persistence = require("persistence")
      persistence.setup(opts)

      vim.api.nvim_create_user_command(CMD_NO_SESSION, function(_) end, {}) -- Is the requirement mis-documented in Neodev?
      vim.api.nvim_create_autocmd("User", {
        pattern = { "LazyDone" },
        group = vim.api.nvim_create_augroup("LoadSession", { clear = true }),
        callback = function()
          if vim.tbl_contains(vim.v.argv, "+" .. CMD_NO_SESSION) then
            require("persistence").stop()
            return
          end
          -- Apparently I don't even have to delay it with `timer_start`, just send it to main vim loop.
          -- If I load it right here, the session loads fine but buffers don't have treesitter etc
          -- To me this indicates that Lazyvim's `started` event is fired while plugins are
          -- still in a queue sent to the vim event loop, might be unwanted behavior on lazy.nvim's end
          if vim.o.filetype ~= "lazy" then
            vim.schedule(persistence.load)
            return
          end

          vim.cmd.close()
          -- TODO: delay load of persistence
          vim.schedule(function()
            persistence.load()
            require("lazy").show()
          end)
          vim.api.nvim_del_augroup_by_name("LoadSession")
          vim.api.nvim_del_user_command(CMD_NO_SESSION)
        end,
      })
    end,
  },
}
