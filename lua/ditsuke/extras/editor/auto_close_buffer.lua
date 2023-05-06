-- > Heuristic buffer close
-- Automatically close unedited buffers after some threshold
return {
  "axkirillov/hbac.nvim",
  dependencies = {
    "bufferline.nvim",
    ---@type LazyKeys[]
    keys = {
      {
        "<leader>bp",
        "<Cmd>Hbac toggle_pin<CR><Cmd>BufferLineTogglePin<CR>",
        desc = "Toggle pin (+ Hbac)",
      },
    },
  },
  opts = {
    threshold = 10,
  },
}
