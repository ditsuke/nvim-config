local util = require("utils")

return {
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

  {
    "jay-babu/mason-null-ls.nvim",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        util.list_insert_unique(opts.ensure_installed, { "gomodifytags", "gofumpt", "iferr", "impl" })
      end
    end,
  },
  {
    -- DAP
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
}
