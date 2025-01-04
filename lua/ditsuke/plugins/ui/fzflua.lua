return {
  "ibhagwan/fzf-lua",
  keys = {
    { "<C-`>", LazyVim.pick("colorschemes"), desc = "Colorscheme with Preview" },
    { "<leader>tr", "<cmd>FzfLua resume<cr>", desc = "Resume" },
  },
  opts = function(_, opts)
    -- Override on_create to add my up/down binds
    local old_on_create = opts.on_create
    opts.on_create = function()
      if old_on_create ~= nil then
        old_on_create()
      end
      vim.keymap.set("t", "<C-j>", "<Down>", { silent = true, buffer = true })
      vim.keymap.set("t", "<C-k>", "<Up>", { silent = true, buffer = true })
    end
    return opts
  end,
}
