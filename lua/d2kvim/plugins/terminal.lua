return {
  {
    "akinsho/toggleterm.nvim",
    config = true,
    keys = function() -- either lazy.nvim must stop evaluating this with plugin not loaded or I need to adopt another strategy.
      return {
        {
          "<F60>",
          function()
            local count = vim.v["count"] or 1
            require("toggleterm").toggle(count, nil, nil, "float")
          end,
          mode = { "n", "t" },
        },
      }
    end,
  },
}
