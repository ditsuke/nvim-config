local M = {}

M.did_init = false
function M.init()
  if M.did_init then
    return
  end
  M.did_init = true

  -- Options must also apply when opening a file or directory from the command
  -- line, including cmdheight=0 so no blank command row sits below the statusline.
  require("ditsuke.config.options")

  if vim.fn.argc(-1) == 0 then
    -- autocmds and keymaps can wait to load
    vim.api.nvim_create_autocmd("User", {
      group = vim.api.nvim_create_augroup("d2kvim", { clear = true }),
      pattern = "VeryLazy",
      callback = function()
        local timer = vim.loop.new_timer()
        if timer == nil then
          return
        end
        -- HACK: delay loading of files so they're evaluated after `lazyvim.config.{keymaps,autocmds}`
        vim.loop.timer_start(
          timer,
          100,
          0,
          vim.schedule_wrap(function()
            require("ditsuke.config.autocmds")
            require("ditsuke.config.keymaps")
          end)
        )
      end,
    })
  else
    -- load them now so they affect the opened buffers
    require("ditsuke.config.autocmds")
    require("ditsuke.config.keymaps")
  end
end

return M
