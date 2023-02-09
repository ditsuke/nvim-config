return {
  "nvim-telescope/telescope.nvim",
  keys = {
    { "<leader>bs", require("telescope.builtin").buffers, desc = "Buffer Search" },
  },
  opts = function(_, opts)
    local actions = require("telescope.actions")
    if opts.defaults == nil then
      opts.defaults = {}
    end

    if opts.mappings == nil then
      opts.mappings = { n = {}, i = {} }
    end

    local mappings = opts.defaults.mappings

    -- @todo revert to defaults
    mappings.i["<C-n>"] = actions.cycle_history_next
    mappings.i["<C-p>"] = actions.cycle_history_prev
    mappings.i["<C-J>"] = actions.move_selection_next
    mappings.i["<C-K>"] = actions.move_selection_previous
  end,
}
