return {
  {
    "jay-babu/mason-null-ls.nvim",
    opts = {
      automatic_setup = true,
      automatic_installation = false,
      ensure_installed = {
        -- "pylint",
        "black",
        "isort",
      },
    },
    init = function(_)
      require("mason-null-ls").setup_handlers({})
    end,
  },
}
