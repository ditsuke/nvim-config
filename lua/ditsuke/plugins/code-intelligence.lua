return {
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "stylua", "shfmt", "selene", "buf", "proselint" } },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        sh = { "shfmt" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        lua = { "selene" },
        luau = { "selene" },
        proto = { "buf_lint" },
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    event = "LazyFile",
    dependencies = {
      -- The Refactoring library based off the Refactoring book by Martin Fowler
      "ThePrimeagen/refactoring.nvim",
    },
    opts = function(_, opts)
      local null_ls = require("null-ls")
      -- None-ls supplies code actions only; Conform and nvim-lint own
      -- formatting and diagnostics respectively.
      local code_action = require("null-ls.methods").internal.CODE_ACTION
      opts.sources = vim.tbl_filter(
        function(source)
          return source.method == code_action
            or (type(source.method) == "table" and vim.tbl_contains(source.method, code_action))
        end,
        opts.sources or {}
      )
      table.insert(opts.sources, null_ls.builtins.code_actions.refactoring)
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
        "none-ls.nvim",
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
      diagnostics = { virtual_text = false, virtual_lines = false },
      inlay_hints = {
        enabled = true,
      },
      servers = {
        ["*"] = {
          capabilities = {
            textDocument = {
              foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
              },
            },
          },
        },
        -- For markdown
        marksman = {
          ---@type lsp.ClientCapabilities
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
