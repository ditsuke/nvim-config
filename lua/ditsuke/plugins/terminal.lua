local function toggleterm()
  -- Need to escape from insert mode if we're in it
  local mode = vim.api.nvim_get_mode().mode
  if mode == "i" then
    vim.cmd.stopinsert()
  end
  local count = vim.v["count"] or 1
  require("toggleterm").toggle(count, nil, nil, "float")
end

return {
  {
    "akinsho/toggleterm.nvim",
    config = true,
    keys = function() -- either lazy.nvim must stop evaluating this with plugin not loaded or I need to adopt another strategy.
      return {
        {
          "<F60>",
          toggleterm,
          mode = { "n", "t", "i" },
        },
        {
          "<C-\\>",
          toggleterm,
          mode = { "n", "t", "i" },
        },
      }
    end,
  },
}
