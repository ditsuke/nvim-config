vim.api.nvim_create_autocmd("User", {
  pattern = { "LazyDone" },
  group = vim.api.nvim_create_augroup("add more toggles", { clear = true }),
  callback = function()
    -- mouse
    Snacks.toggle({
      name = "Mouse",
      get = function() return vim.opt.mouse["_value"] == "a" end,
      set = function(state)
        local new_state = state and "a" or "v"
        vim.opt.mouse = new_state
      end,
    }):map("<leader>uM")

    -- statusline
    vim.g.state__statusline_enabled = true
    local UIUtils = require("ditsuke.utils.ui")
    Snacks.toggle({
      name = "Statusline",
      get = function() return vim.g.state__statusline_enabled end,
      set = function(state)
        if state then
          vim.g.state__statusline_enabled = true
          UIUtils.set_lualine_statusline(true)
        else
          vim.g.state__statusline_enabled = false
          UIUtils.set_lualine_statusline(false)
        end
      end,
    }):map("<leader>uB")
  end,
})

return {
  "folke/snacks.nvim",
  optional = true,
}
