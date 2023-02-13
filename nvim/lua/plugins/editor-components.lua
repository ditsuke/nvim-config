return {
  {
    -- TODO: setup
    -- Jump between files and terminals
    "ThePrimeagen/harpoon",
    event = "VeryLazy",
  },
  {
    -- File tree
    "nvim-neo-tree/neo-tree.nvim",
    keys = function(_, keys)
      keys[#keys + 1] = {
        "<leader>o",
        function()
          require("neo-tree.command").execute({ focus = true })
        end,
        desc = "Focus Neotree",
      }
      return keys
    end,
    opts = {
      window = {
        width = 30,
        position = "right",
      },
    },
  },
  {
    -- Extensible fuzzy searcher for files, buffers, and virtually everything else
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>bs", require("telescope.builtin").buffers, desc = "Buffer Search" },
    },
    opts = function(_, opts)
      local actions = require("telescope.actions")
      if opts.defaults == nil then
        opts.defaults = {}
      end

      if opts.mappings == nil then
        opts.mappings = { n = {}, i = {} }
      end

      local mappings = opts.defaults.mappings

      -- @todo revert to defaults
      mappings.i["<C-n>"] = actions.cycle_history_next
      mappings.i["<C-p>"] = actions.cycle_history_prev
      mappings.i["<C-J>"] = actions.move_selection_next
      mappings.i["<C-K>"] = actions.move_selection_previous
    end,
  },
  {
    -- Completions
    "hrsh7th/nvim-cmp",
    --- @param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.mapping = cmp.mapping.preset.insert({
        ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),

        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete({}),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      })
    end,
  },
}
