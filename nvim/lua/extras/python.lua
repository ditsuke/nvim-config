local util = require("utils")

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
  {
    "neotest",
    dependencies = { "nvim-neotest/neotest-python" },
    opts = function(_, opts)
      table.insert(
        opts.adapters,
        require("neotest-python")({
          dap = { justMyCode = false },
        })
      )
      util.list_insert_unique(opts.vimtest_ignore, {
        "python",
      })
    end,
  },

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
