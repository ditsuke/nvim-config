-- if true then
--   return {}
-- end

--- Keep track of extensions to load after telescope is setup.
---@type string[]
local telescope_extensions = {}

local function add_extension(ext) telescope_extensions[#telescope_extensions + 1] = ext end

-- Extensible fuzzy searcher for files, buffers, and virtually everything else
local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && \
          cmake --build build --config Release",
      config = function() add_extension("fzf") end,
    },
    {
      "nvim-telescope/telescope-frecency.nvim",
      dependencies = { { "kkharji/sqlite.lua" } },
      config = function() add_extension("frecency") end,
    },
    {
      "ryanmsnyder/toggleterm-manager.nvim",
      dependencies = {
        "akinsho/toggleterm.nvim",
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim", -- only needed because it's a dependency of telescope
      },
      keys = {
        {
          "<M-BSlash>",
          function()
            require("telescope").extensions.toggleterm_manager.toggleterm_manager({
              preview = { hide_on_startup = false },
            })
          end,
          desc = "find terminals",
          mode = { "t", "i", "n" },
        },
      },
      opts = function(_, _)
        local actions = require("toggleterm-manager").actions
        return {
          mappings = {
            i = {
              ["<CR>"] = { action = actions.open_term, exit_on_action = true },
              ["<S-CR>"] = {
                action = function(_, _)
                  -- Manager's default create_term action uses vim.ui for input,
                  -- plus has some other issues such as passing the `hidden` option
                  -- to Terminal:new, which somehow disables keybindings in the created
                  -- terminal.
                  local actions_state = require("telescope.actions.state")
                  local Terminal = require("toggleterm.terminal").Terminal
                  local text = actions_state.get_current_line()
                  if text == nil or #text == 0 then
                    return
                  end
                  local new_term = Terminal:new({
                    id = nil,
                    display_name = text,
                  })
                  new_term:open()
                end,
                exit_on_action = true,
              },
              ["<C-d>"] = { action = actions.delete_term, exit_on_action = false },
            },
            n = {
              ["<CR>"] = { action = actions.create_and_name_term, exit_on_action = true },
              ["x"] = { action = actions.delete_term, exit_on_action = false },
            },
          },
        }
      end,
    },
    {
      "debugloop/telescope-undo.nvim",
      config = function() add_extension("undo") end,
    },
    {
      -- > `telescope-file-browser.nvim` is a file browser extension for telescope.nvim.
      -- > It supports synchronized creation, deletion, renaming, and moving of files and folders powered by telescope.nvim and plenary.nvim.
      "nvim-telescope/telescope-file-browser.nvim",
      config = function() add_extension("file_browser") end,
    },
  },
  keys = {
    {
      -- Disable LazyVim's default <leader>sR keybind for resuming telescope sessions.
      "<leader>sR",
      false,
    },
    {
      "<leader>fF",
      function() require("telescope.builtin").find_files({ hidden = false, no_ignore = false }) end,
      desc = "[f]ind [f]iles",
    },
    {
      "<leader>fb",
      -- stylua: ignore
      function() require("telescope").extensions.file_browser.file_browser({ hidden = true, no_ignore = true, path = "%:p:h" }) end,
      desc = "[file] [b]rowser",
    },
    {
      "<leader>o",
      -- stylua: ignore
      function() require("telescope").extensions.file_browser.file_browser({ hidden = true, no_ignore = true, path = "%:p:h" }) end,
      desc = "[o]pen file browser",
    },
    { "<leader>bs", function() require("telescope.builtin").buffers({ sort_mru = true }) end, desc = "[s]earch" },
    {
      "<leader>,",
      function()
        require("telescope.builtin").buffers({
          sort_mru = true,
          -- entry_maker = function(entry)
          --   return {
          --     value = entry,
          --     display = entry[1],
          --     ordinal = entry[1],
          --   }
          -- end,
        })
      end,
      desc = "search buffers",
    },
    { "<F1>", function() require("telescope.builtin").help_tags() end, desc = "Search :help" },
    {
      "<C-`>",
      function() require("telescope.builtin").colorscheme({ enable_preview = true }) end,
      desc = "Preview and switch colorschemes/themes",
    },
    {
      "<leader>sS",
      function()
        require("lazyvim.util.pick").open("lsp_dynamic_workspace_symbols", {
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
        })
      end,
    },
    {
      "<leader>su",
      function() require("telescope").extensions.undo.undo() end,
      desc = "[u]ndo tree",
    },
    {
      "<leader>fr",
      function()
        require("telescope").extensions.frecency.frecency({
          workspace = "CWD",
        })
      end,
      desc = "[r]ecent",
    },
    {
      "<leader>tr",
      function() require("telescope.builtin").resume() end,
      desc = "[r]esume",
    },
  },
}

M.opts = function(_, opts)
  local actions = require("telescope.actions")

  local fzf_opts = {
    fuzzy = true, -- false will only do exact matching
    override_generic_sorter = true, -- override the generic sorter
    override_file_sorter = true, -- override the file sorter
    case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    -- the default case_mode is "smart_case"
  }

  local frecency_opts = {
    db_root = "~/.local/share/nvim",
  }

  local undo_opts = {
    use_delta = true,
    side_by_side = true,
    layout_strategy = "vertical",
    layout_config = {
      preview_height = 0.8,
    },
  }

  -- BUG: Importing actions like this causes an override of the setup mappings, somehow.
  -- I should report this upstream. (TODO)
  -- local fb_actions = require("telescope").extensions.file_browser.actions

  local fb_actions = require("telescope._extensions.file_browser.actions")
  local file_browser_opts = {
    theme = "ivy",
    layout_config = {
      height = 15,
    },
    depth = 1,
    -- disables netrw and use telescope-file-browser in its place
    hijack_netrw = true,
    mappings = {
      ["i"] = {
        -- Avoid overriding expected keybinds to delete words and scroll previews.
        -- Instead, assign them more appropriate shortcuts.
        ["<C-F>"] = false,
        ["<C-w>"] = function(_bufnr) -- works? but it maps C-w to :norm / <esc>
          -- <C-w> works for window commands (whatever that is) by default in telescope insert mode,
          -- so we need to remap to <C-S-w> to get the expected behavior (delete word)
          -- Ref: https://github.com/nvim-telescope/telescope.nvim/issues/1579#issuecomment-989767519
          vim.api.nvim_input("<C-S-w>")
        end,
        ["<A-f>"] = fb_actions.toggle_browser,
        ["<A-w>"] = fb_actions.goto_cwd,
      },
      ["n"] = {
        -- your custom normal mode mappings
      },
    },
  }

  local overrides = {
    extensions = {
      fzf = fzf_opts,
      frecency = frecency_opts,
      undo = undo_opts,
      file_browser = file_browser_opts,
    },
    ---@type table<string, telescope.picker.opts>
    pickers = {
      lsp_dynamic_workspace_symbols = {
        -- Manually set sorter, for some reason not picked up automatically
        -- Ref: https://github.com/nvim-telescope/telescope.nvim/issues/2104#issuecomment-1223790155
        sorter = require("telescope").extensions.fzf.native_fzf_sorter(fzf_opts),
      },
      buffers = {
        mappings = {
          n = {
            ["d"] = function(prompt_bufnr)
              local current_picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
              current_picker:delete_selection(function(selection)
                local force = vim.api.nvim_buf_get_option(selection.bufnr, "buftype") == "terminal"
                local ok = pcall(require("mini.bufremove").delete, selection.bufnr, force)
                return ok
              end)
            end,
          },
        },
      },
      toggleterm_manager = {
        previewer = require("telescope.previewers.term_previewer"),
      },
    },
    -- Use the `ivy` theme, inspired by Emacs Ivy!
    -- Also disable previews and reduce height
    defaults = require("telescope.themes").get_ivy({
      preview = { hide_on_startup = true }, -- An experiment (I might enable just for grep/livegrep)
      layout_config = {
        height = 15,
      },
      mappings = {
        i = {
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
          ["<C-J>"] = actions.move_selection_next,
          ["<C-K>"] = actions.move_selection_previous,
          ["<M-p>"] = require("telescope.actions.layout").toggle_preview,
        },
      },
    }),
  }

  return vim.tbl_deep_extend("force", opts, overrides)
end

--- Custom setup function to load extensions after telescope setup.
--- Side effect: some extensions will be loaded twice, but that's okay (I guess).
M.setup = function(_, opts)
  local telescope = require("telescope")
  telescope.setup(opts)
  for _, e in ipairs(telescope_extensions) do
    telescope.load_extension(e)
  end
end

return M
