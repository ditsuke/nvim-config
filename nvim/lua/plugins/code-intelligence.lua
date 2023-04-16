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
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      automatic_setup = true,
      automatic_installation = false,
      ensure_installed = {
        "black",
        "stylua",
        "ruff",
      },
    },
    config = function(_, opts)
      local mnls = require("mason-null-ls")
      mnls.setup(opts)
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
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = false, -- Managed by `lsp_lines`
      },
      servers = {
        marksman = {}, -- For markdown
      },
    },
  },
}
