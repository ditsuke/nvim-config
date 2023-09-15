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
    opts = {
      winbar = {
        enabled = true,
        name_formatter = function(term) --  term: Terminal
          return term.name
        end,
      },
      float_opts = {
        -- The border key is almost the same as 'nvim_open_win'
        -- see :h nvim_open_win for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        border = "curved",
        -- like `size`, width and height can be a number or function which is passed the current terminal
        -- width = <value>,
        -- height = <value>,
        winblend = 10,
        zindex = 100,
      },
    },
    keys = {
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
    },
  },
}
