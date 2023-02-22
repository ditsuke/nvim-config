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
      {
        "<leader>sS",
        lazyUtils.telescope("lsp_dynamic_workspace_symbols", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
          },
        }),
      },
      {
        "<leader>tr",
        function()
          require("telescope.builtin").resume()
        end,
      },
    },
    opts = function(_, opts)
      local actions = require("telescope.actions")

      local fzf_opts = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      }

      local overrides = {
        extensions = {
          fzf = fzf_opts,
        },
        pickers = {
          lsp_dynamic_workspace_symbols = {
            -- Manually set sorter, for some reason not picked up automatically
            sorter = require("telescope").extensions.fzf.native_fzf_sorter(fzf_opts),
          },
        },
        defaults = {
          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-J>"] = actions.move_selection_next,
              ["<C-K>"] = actions.move_selection_previous,
            },
          },
        },
      }

      return vim.tbl_deep_extend("force", opts, overrides)
    end,
    init = function()
      require("telescope").load_extension("fzf")
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    lazy = true,
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "hrsh7th/cmp-path",
      "f3fora/cmp-spell",
      "ray-x/cmp-treesitter",
      "saadparwaiz1/cmp_luasnip",
      "tamago324/cmp-zsh",
      "uga-rosa/cmp-dictionary",
      "amarakon/nvim-cmp-fonts",
      "onsails/lspkind.nvim",
    },
    opts = function(_, _)
      local cmp = require("cmp")
      local sources = {
        {
          { name = "nvim_lsp" },
          { name = "nvim_lua" },
          { name = "luasnip" },
        },
        {
          { name = "treesitter" },
          { name = "buffer" },
          { name = "path" },
          { name = "spell" },
          { name = "dictionary" },
          { name = "fonts", options = { space_filter = "-" } },
        },
      }

      if vim.fn.has("win32") ~= 1 then
        table.insert(sources[2], { name = "zsh" })
      end

      local winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:CursorLine,Search:Search"

      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").load()

      local function has_words_before()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))

        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      -- <Tab> is used by Copilot, I found the plugin doesn't work
      -- if I use <Tab> for nvim-cmp or any other plugin
      -- local mappings for nvim-cmp.
      local mapping = {
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-j>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif has_words_before() then
            cmp.mapping.complete({})
          else
            fallback()
          end
        end, { "i", "s", "c" }),
        ["<C-k>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { "i", "s", "c" }),
        -- ["<C-j>"] = cmp.mapping(function(fallback)
        --   if luasnip.expand_or_jumpable() then
        --     luasnip.expand_or_jump()
        --   else
        --     fallback()
        --   end
        -- end, { "i", "s" }),
        -- ["<C-k>"] = cmp.mapping(function(fallback)
        --   if luasnip.jumpable(-1) then
        --     luasnip.jump(-1)
        --   else
        --     fallback()
        --   end
        -- end, { "i", "s" }),
        ["<C-Space>"] = cmp.mapping.complete({}),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }

      -- cmp plugin
      local CMP_SYMBOLS = {
        Text = " ",
        Method = " ",
        Function = "",
        Constructor = " ",
        Field = " ",
        Variable = " ",
        Class = " ",
        Interface = " ",
        Module = " ",
        Property = " ",
        Unit = "塞",
        Value = " ",
        Enum = " ",
        Keyword = " ",
        Snippet = " ",
        Color = " ",
        File = " ",
        Reference = " ",
        Folder = " ",
        EnumMember = " ",
        Constant = " ",
        Struct = " ",
        Event = "",
        Operator = " ",
        TypeParameter = " ",
      }

      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "cmp_git" },
          { name = "nvim_lsp" },
          { name = "nvim_lua" },
          { name = "nvim_lsp_document_symbol" },
          { name = "buffer" },
          { name = "dictionary" },
          { name = "spell" },
          { name = "path" },
        }),
      })

      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "nvim_lsp" },
          { name = "nvim_lsp_document_symbol" },
          { name = "dictionary" },
          { name = "buffer" },
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "cmdline" },
          { name = "path", options = { trailing_slash = true, label_trailing_slash = true } },
          { name = "dictionary" },
          { name = "buffer" },
        }),
      })

      return {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered({ winhighlight = winhighlight }),
          documentation = cmp.config.window.bordered({ winhighlight = winhighlight }),
          preview = cmp.config.window.bordered({ winhighlight = winhighlight }),
        },
        formatting = {
          format = require("lspkind").cmp_format({
            mode = "symbol",
            ellipsis_char = "…",
            menu = {
              nvim_lsp = "lsp",
              nvim_lua = "lua",
              luasnip = "snip",
              buffer = "buf",
              path = "path",
              calc = "calc",
              vsnip = "snip",
              nvim_lsp_signature_help = "sign",
              treesitter = "ts",
              spell = "spel",
              dictionary = "dict",
              zsh = "zsh",
              ["vim-dadbod-completion"] = "db",
            },
            symbol_map = CMP_SYMBOLS,
          }),
        },
        mapping = cmp.mapping.preset.insert(mapping),
        sources = cmp.config.sources(sources[1], sources[2]),
      }
    end,
  },
}
