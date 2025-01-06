return {
  "saghen/blink.cmp",

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    completion = {
      list = {
        selection = "auto_insert",
      },
    },
    keymap = {
      ["<C-j>"] = { "select_next", "fallback" },
      ["C-k>"] = { "select_prev", "fallback" },
      ["<Tab>"] = { "select_next" },
    },
  },
}
