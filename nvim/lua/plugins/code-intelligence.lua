return {
  {
    "williamboman/mason.nvim",
    opts = function(_, _)
      -- NOTE: since we're using mason-null-ls, get rid of
      -- ensure_installed directives for linters/formatters
      return {
        ensure_installed = {},
      }
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    opts = {
      automatic_setup = true,
      automatic_installation = false,
      ensure_installed = {
        "black",
        "stylua",
        "ruff",
      },
    },
    init = function(_)
      require("mason-null-ls").setup_handlers({})
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = {
        nls.builtins.diagnostics.ruff,
        nls.builtins.formatting.ruff,
        nls.builtins.formatting.black,
        nls.builtins.formatting.stylua,
      }
      return opts
    end,
  },
}