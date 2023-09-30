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
    dependencies = {
      -- The Refactoring library based off the Refactoring book by Martin Fowler
      "ThePrimeagen/refactoring.nvim",
    },
    opts = function(_, opts)
      local null_ls = require("null-ls")
      opts.sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.buf,
        null_ls.builtins.code_actions.refactoring,
        null_ls.builtins.diagnostics.selene,
        -- bash
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.diagnostics.shellcheck,
      }
      return opts
    end,
  },

  -- > A framework for running functions on Tree-sitter nodes, and updating the buffer with the result.
  {
    "ckolkey/ts-node-action",
    event = "BufReadPost",
    dependencies = {
      "nvim-treesitter",
      {
        "null-ls.nvim",
        opts = function(_, opts)
          local null_ls = require("null-ls")
          table.insert(opts.sources, null_ls.builtins.code_actions.ts_node_action)
          return opts
        end,
      },
    },
    opts = {},
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
        -- For markdown
        marksman = {
          ---@type nio.lsp.types.ClientCapabilities
          capabilities = {
            textDocument = {
              completion = {
                completionItemKind = {
                  valueSet = {
                    15,
                  },
                },
                completionItem = {
                  snippetSupport = true,
                },
              },
            },
          },
        },
        clangd = {
          filetypes = { "c", "cpp" },
        },
      },
    },
  },
}
