local Util = require("ditsuke.utils")

-- vim.api.nvim_create_autocmd({ "LspAttach" }, {
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     if client.name == "gopls" then
--       vim.notify("gopls attached")
--       client.server_capabilities.semanticTokensProvider = nil
--     end
--   end,
-- })

return {
  -- Configure Go integrations (commands, LSP)
  {
    "ray-x/go.nvim",
    lazy = true,
    -- event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "nvim-treesitter/nvim-treesitter",
      {
        "neovim/nvim-lspconfig",
        opts = function(_, og_opts)
          return vim.tbl_deep_extend("force", og_opts, {
            servers = {
              gopls = require("go.lsp").config(),
            },
          })
        end,
      },
    },
    opts = {
      lsp_cfg = false,
      lsp_keymaps = false,
    },
    config = function(_, opts) require("go").setup(opts) end,
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },

  -- Add Go and related file formats to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        Util.list_insert_unique(opts.ensure_installed, { "go", "gomod", "gosum", "gowork" })
      end
    end,
  },

  -- Add neotest adapter for go
  require("ditsuke.utils.lang").neotest_extension_spec({ { "nvim-neotest/neotest-go" } }, { "go" }),

  -- Configure some formatters/auto-fixers.
  -- NOTE: Consider adding `iferr` (not available)
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local builtins = require("null-ls").builtins
      Util.list_insert_unique(opts.sources, {
        builtins.code_actions.gomodifytags,
        builtins.formatting.gofumpt,
        builtins.code_actions.impl,
        builtins.diagnostics.golangci_lint,
      })
    end,
  },

  -- Configure debug adapter
  {
    "leoluz/nvim-dap-go",
    dependencies = {
      "mfussenegger/nvim-dap",
      {
        "jay-babu/mason-nvim-dap.nvim",
        opts = function(_, opts)
          if type(opts.ensure_installed) == "table" then
            Util.list_insert_unique(opts.ensure_installed, "delve")
          end
        end,
      },
    },
    ft = "go",
    config = true,
  },

  -- Consider: `olexsmir/gopher.nvim`.
  --  - Minimal replacement for `go.nvim`
  --  - Configure DAP on its own.
  --  - :Go* commands (should be redundant with `go.nvim`'s)
}
