-- local Util = require("ditsuke.utils")

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {},
      },
    },
  },

  -- Add Neotest adapter for python (pytest/python-unittest)
  require("ditsuke.utils.lang").neotest_extension_spec({
    {
      "nvim-neotest/neotest-python",
      opts = {
        dap = { justMyCode = false },
      },
    },
  }, { "python" }),

  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      -- local nls = require("null-ls")
      -- Util.list_insert_unique(opts.sources, {
      -- nls.builtins.diagnostics.ruff,
      -- nls.builtins.formatting.ruff,
      -- nls.builtins.formatting.black,
      -- })
      return opts
    end,
  },
  { "mfussenegger/nvim-dap-python", ft = "python", config = function() require("dap-python").setup("python") end },
}
