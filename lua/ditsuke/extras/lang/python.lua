local util = require("ditsuke.utils")

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {},
      },
    },
  },

  -- Add neotest adapter for python (pytest/python-unittest)
  require("ditsuke.utils.lang").neotest_extension_spec({
    {
      "nvim-neotest/neotest-python",
      opts = {
        dap = { justMyCode = false },
      },
    },
  }, { "python" }),

  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      util.list_insert_unique(opts.sources, {
        nls.builtins.diagnostics.ruff,
        nls.builtins.formatting.ruff,
        nls.builtins.formatting.black,
      })
      return opts
    end,
  },
  { "mfussenegger/nvim-dap-python", ft = "python", config = function() require("dap-python").setup("python") end },
}
