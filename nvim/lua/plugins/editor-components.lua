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
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && \
        cmake --build build --config Release && \
        cmake --install build --prefix build",
      },
    },
    keys = {
      { "<leader>bs", require("telescope.builtin").buffers, desc = "Buffer Search" },
    },
    opts = function(_, opts)
      local extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
      }
      vim.tbl_extend("force", extensions, opts.extensions or {})
      opts.extensions = extensions

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
    init = function()
      require("telescope").load_extension("fzf")
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
