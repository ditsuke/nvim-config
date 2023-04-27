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
      automatic_installation = true,
    },
    config = function(_, opts)
      local mnls = require("mason-null-ls")
      mnls.setup(opts)
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local null_ls = require("null-ls")
      opts.sources = {
        null_ls.builtins.completion.spell,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.buf,
      }
      return opts
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      capabilities = {
        textDocument = {
          foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
          },
        },
      },
      servers = {
        marksman = {}, -- For markdown
      },
    },
  },
}
