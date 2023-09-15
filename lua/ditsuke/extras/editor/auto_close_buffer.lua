-- > Heuristic buffer close
-- Automatically close unedited buffers after some threshold
return {
  "axkirillov/hbac.nvim",
  event = "BufReadPre",
  dependencies = {
    {
      "bufferline.nvim",
      event = "VeryLazy",
      ---@type LazyKeys[]
      keys = {
        {
          "<leader>bp",
          "<Cmd>Hbac toggle_pin<CR><Cmd>BufferLineTogglePin<CR>",
          desc = "Toggle pin (+ Hbac)",
        },
      },
    },
    {
      "nvim-telescope/telescope.nvim",
      keys = {
        {
          "<leader>,",
          function() require("hbac").telescope() end,
          desc = "Find buffers",
        },
      },
    },
  },
  opts = {
    threshold = 10,
  },
}
