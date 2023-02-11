return {
  {
    "ggandor/flit.nvim",
    opts = {
      multiline = false,
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = function(_, keys)
      keys[#keys + 1] = {
        "<leader>o",
        function()
          require("neo-tree.command").execute({ focus = true })
        end,
        desc = "Focus Neotree",
      }
      return keys
    end,
    opts = {
      window = {
        width = 30,
        position = "right",
      },
    },
  },
}
