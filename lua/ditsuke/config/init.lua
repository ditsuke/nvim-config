local M = {}

function M.init()
  if vim.fn.argc(-1) == 0 then
    require("ditsuke.config.options")

    -- autocmds and keymaps can wait to load
    vim.api.nvim_create_autocmd("User", {
      group = vim.api.nvim_create_augroup("ditsukeCfg", { clear = true }),
      pattern = "VeryLazy",
      callback = function()
        require("ditsuke.config.autocmds")
        require("ditsuke.config.keymaps")
      end,
    })
  else
    -- load them now so they affect the opened buffers
    require("ditsuke.config.autocmds")
    require("ditsuke.config.keymaps")
  end
end

return M
