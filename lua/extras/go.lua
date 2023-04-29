local util = require("utils")

return {
  -- Configure Go integrations (commands, LSP)
  {
    "ray-x/go.nvim",
    event = { "CmdlineEnter" },
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
    },
    config = function(opts) require("go").setup(opts) end,
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },

  -- Add Go and related file formats to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        util.list_insert_unique(opts.ensure_installed, { "go", "gomod", "gosum", "gowork" })
      end
    end,
  },

  -- Add neotest adapter for go
  {
    "neotest",
    dependencies = { "nvim-neotest/neotest-go" },
    opts = function(_, opts)
      table.insert(opts.adapters, require("neotest-go"))
      util.list_insert_unique(opts.vimtest_ignore, {
        "go",
      })
    end,
  },

  -- Configure some formatters/auto-fixers.
  -- TODO: replace this setup with `null-ls`
  {
    "jay-babu/mason-null-ls.nvim",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        util.list_insert_unique(opts.ensure_installed, { "gomodifytags", "gofumpt", "iferr", "impl" })
      end
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
            util.list_insert_unique(opts.ensure_installed, "delve")
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
