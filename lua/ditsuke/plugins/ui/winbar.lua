return {
  "Bekaboo/dropbar.nvim",
  lazy = false,
  opts = {
    bar = {
      enable = function(buf, win)
        return vim.bo[buf].buftype == ""
          and vim.api.nvim_buf_get_name(buf) ~= ""
          and vim.api.nvim_win_get_config(win).relative == ""
          and not vim.tbl_contains({ "neo-tree", "toggleterm", "Trouble" }, vim.bo[buf].filetype)
      end,
    },
  },
  keys = {
    { "<leader>;", function() require("dropbar.api").pick() end, desc = "Pick breadcrumb" },
  },
}
