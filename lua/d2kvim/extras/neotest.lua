-- > A framework for interacting with tests within NeoVim.
-- TODO: factor out language configurations to their own layers
-- TODO: Install vim-test + neotest-vim-test for increased language support/compat
local M = {
  "nvim-neotest/neotest",
  event = "BufEnter",
  dependencies = {
    "plenary.nvim",
    -- Decouple updateTime from the `CursorHold` event used by NeoTest
    -- Why?
    -- - https://github.com/nvim-neotest/neotest#installation
    -- - https://github.com/antoinemadec/FixCursorHold.nvim/issues/13
    "antoinemadec/FixCursorHold.nvim",
    {
      "neodev.nvim",
      opts = {
        library = { plugins = { "neotest" }, types = true },
      },
    },
    "nvim-neotest/neotest-vim-test",
    "nvim-neotest/neotest-plenary",
  },
  opts = function(_, og_opts)
    return {
      adapters = {
        require("neotest-plenary"),
      },
      -- HACK: non-standard extension to opts to enable language
      -- layers to exclude filetypes covered by standard neotest adapters
      -- from the blanket `vim-test` adapter
      vimtest_ignore = {
        "lua",
      },
    }
  end,
  keys = {
    { "<leader>ctt", function() require("neotest").run.run() end, desc = "test nearest" },
    { "<leader>ct%", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "test file (%)" },
    { "<leader>ctd", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "test nearest (debug)" },
    { "<leader>cts", function() require("neotest").run.stop() end, desc = "stop test (nearest)" },
    { "<leader>cto", function() require("neotest").output.open() end, desc = "neotest output (nearest)" },
    { "<leader>ctO", function() require("neotest").output_panel.open() end, desc = "neotest output panel (bottom)" },
    { "<leader>ctS", function() require("neotest").summary.open() end, desc = "neotest summary panel (sidebar)" },
  },
}

function M.config(_, opts)
  table.insert(
    opts.adapters,
    require("neotest-vim-test")({
      ignore_filetypes = opts.vimtest_ignore,
    })
  )

  -- get neotest namespace (api call creates or returns namespace)
  local neotest_ns = vim.api.nvim_create_namespace("neotest")
  vim.diagnostic.config({
    virtual_text = {
      format = function(diagnostic)
        local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
        return message
      end,
    },
  }, neotest_ns)

  -- TODO: cleanup
  require("config.shared").logger("setting up neotest with: ", opts)
  require("neotest").setup(opts)
end

return M
