return {
  {
    "akinsho/toggleterm.nvim",
    opts = true,
    keys = function() -- either lazy.nvim must stop evaluating this with plugin not loaded or I need to adopt another strategy.
      local toggleterm = require("toggleterm")
      local toggle = require("toggleterm.ui")
      toggle.get_origin_window()
      return {
        {
          "<F60>",
          function()
            toggleterm.toggle(1, nil, nil, nil)
          end,
          mode = { "n", "t" },
        },
      }
    end,
  },
}
