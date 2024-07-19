local TS_MAX_LINE_USUAL = 6000
local TS_MAX_LINE_HIGH_IMPACT = 1000
local disable_on_large_buffers_fn = function(threshold)
  return function(_, bufnr) return vim.api.nvim_buf_line_count(bufnr) > threshold end
end

-- if true then
--   return {}
-- end

return {
  "nvim-treesitter/nvim-treesitter",
  enabled = true,
  init = nil,
  dependencies = {
    { "nvim-treesitter-textobjects", enabled = false, init = nil }, -- Disable textobjects, I'm not using it anyways
    "nvim-treesitter/playground",
    -- highlight same-name identifiers with the same color
    "David-Kunz/markid",
    -- "HiPhish/nvim-ts-rainbow2",
    "nvim-treesitter/nvim-treesitter-refactor",
    -- Show code context (function, etc) on top while navigating ala context.vim
    "nvim-treesitter/nvim-treesitter-context",
    "theHamsta/nvim-dap-virtual-text",
    "windwp/nvim-ts-autotag",
    "andymass/vim-matchup",
  },
  keys = {
    { "<leader>ux", "<Cmd>TSHighlightCapturesUnderCursor<CR>", desc = "Show highlight groups" },
  },
  opts = function(_, opts)
    local queries = require("nvim-treesitter.query")
    local overrides = {
      auto_install = true,
      highlight = {
        disable = disable_on_large_buffers_fn(TS_MAX_LINE_USUAL),
      },
      markid = {
        enable = false,
        disable = disable_on_large_buffers_fn(TS_MAX_LINE_HIGH_IMPACT),
      },
      rainbow = {
        enable = true,
        query = "rainbow-parens",
        max_file_lines = TS_MAX_LINE_USUAL,
      },
      refactor = {
        -- disable = disable_on_large_buffers_fn(TX_MAX_LINE_HIGH_IMPACT),
        highlight_definitions = {
          enable = true,
          clear_on_cursor_move = false,
          is_supported = function(lang)
            local disable_func = disable_on_large_buffers_fn(TS_MAX_LINE_USUAL)
            return queries.has_locals(lang) and not disable_func(nil, vim.api.nvim_get_current_buf())
          end,
        },
        highlight_current_scope = {
          enable = false,
          is_supported = function(lang)
            local disable_func = disable_on_large_buffers_fn(TS_MAX_LINE_USUAL)
            return queries.has_locals(lang) and not disable_func(nil, vim.api.nvim_get_current_buf())
          end,
        },
        smart_rename = {
          enable = true,
          is_supported = function(lang)
            local disable_func = disable_on_large_buffers_fn(TS_MAX_LINE_USUAL)
            return queries.has_locals(lang) and not disable_func(nil, vim.api.nvim_get_current_buf())
          end,
          keymaps = {
            smart_rename = "<leader>cr",
          },
        },
        -- TODO: consider using goto-definition etc
      },
      autotag = {
        enable = true,
        disable = disable_on_large_buffers_fn,
      },
      matchup = {
        enable = true,
        disable = disable_on_large_buffers_fn,
      },
    }
  end,
}
