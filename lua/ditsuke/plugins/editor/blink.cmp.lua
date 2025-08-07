return {
  "saghen/blink.cmp",

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    completion = {
      list = {
        selection = {
          preselect = false,
          auto_insert = true,
        },
      },
    },
    keymap = {
      ["<C-j>"] = { "select_next", "fallback" },
      ["C-k>"] = { "select_prev", "fallback" },
      ["<Tab>"] = { "select_next" },
    },
  },
}
