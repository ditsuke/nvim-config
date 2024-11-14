-- > Heuristic buffer close
-- Automatically close unedited buffers after some threshold
return {
  "axkirillov/hbac.nvim",
  enabled = false,
  event = "BufReadPre",
  dependencies = {
    {
      "bufferline.nvim",
      optional = true,
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
      optional = true,
      keys = {
        {
          "<leader>,",
          function() require("telescope").extensions.hbac.buffers() end,
          desc = "Find buffers",
        },
      },
    },
  },
  opts = {
    threshold = 10,
    close_command = function(bufnr) require("mini.bufremove").delete(bufnr, false) end,
  },
  setup = function(_, opts)
    require("telescope").load_extension("hbac")
    require("hbac").setup(opts)
  end,
}
