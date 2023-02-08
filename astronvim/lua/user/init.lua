--              AstroNvim Configuration Table
-- All configuration changes should go inside of the table below

-- You can think of a Lua "table" as a dictionary like data structure the
-- normal format is "key = value". These also handle array like data structures
-- where a value with no key simply has an implicit numeric key
local config = {

	-- Configure AstroNvim updates
	updater = {
		remote = "origin", -- remote to use
		channel = "nightly", -- "stable" or "nightly"
		version = "v3.*", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
		branch = "v3", -- branch name (NIGHTLY ONLY)
		commit = nil, -- commit hash (NIGHTLY ONLY)
		pin_plugins = true, -- nil, true, false (nil will pin plugins on stable only)
		skip_prompts = false, -- skip prompts about breaking changes
		show_changelog = true, -- show the changelog after performing an update
		auto_quit = false, -- automatically quit the current session after a successful update
		-- remotes = { -- easily add new remotes to track
		--   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
		--   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
		--   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
		-- },
	},

	-- Set colorscheme to use
	colorscheme = "astrodark",

	-- Add highlight groups in any theme
	highlights = {
		-- init = { -- this table overrides highlights in all themes
		--   Normal = { bg = "#000000" },
		-- }
		-- duskfox = { -- a table of overrides/changes to the duskfox theme
		--   Normal = { bg = "#000000" },
		-- },
	},

	-- set vim options here (vim.<first_key>.<second_key> = value)
	options = {
		opt = {
			-- set to true or false etc.
			relativenumber = true, -- sets vim.opt.relativenumber
			number = true, -- sets vim.opt.number
			spell = false, -- sets vim.opt.spell
			signcolumn = "auto", -- sets vim.opt.signcolumn to auto
			wrap = false, -- sets vim.opt.wrap
		},
		g = {
			mapleader = " ", -- sets vim.g.mapleader
			autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
			cmp_enabled = true, -- enable completion at start
			autopairs_enabled = true, -- enable autopairs at start
			diagnostics_enabled = true, -- enable diagnostics at start
			status_diagnostics_enabled = true, -- enable diagnostics in statusline
			icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
			ui_notifications_enabled = true, -- disable notifications when toggling UI elements
		},
	},
	-- If you need more control, you can use the function()...end notation
	-- options = function(local_vim)
	--   local_vim.opt.relativenumber = true
	--   local_vim.g.mapleader = " "
	--   local_vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' } -- removing option from list
	--   local_vim.opt.shortmess = vim.opt.shortmess + { I = true } -- add to option list
	--
	--   return local_vim
	-- end,

	-- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
	diagnostics = {
		virtual_text = true,
		underline = true,
	},

	-- Extend LSP configuration
	lsp = {
		-- enable servers that you already have installed without mason
		servers = {
			-- "pyright"
		},
		formatting = {
			-- control auto formatting on save
			format_on_save = {
				enabled = true, -- enable or disable format on save globally
				allow_filetypes = { -- enable format on save for specified filetypes only
					-- "go",
				},
				ignore_filetypes = { -- disable format on save for specified filetypes
					-- "python",
				},
			},
			disabled = { -- disable formatting capabilities for the listed language servers
				"sumneko_lua",
				"tsserver",
			},
			timeout_ms = 1000, -- default format timeout
			-- filter = function(client) -- fully override the default formatting function
			--   return true
			-- end
		},
		-- easily add or disable built in mappings added during LSP attaching
		mappings = {
			n = {
				-- ["<leader>lf"] = false -- disable formatting keymap
			},
		},
		-- add to the global LSP on_attach function
		-- on_attach = function(client, bufnr)
		-- end,

		-- override the LSP setup handler function based on server name
		-- setup_handlers = {
		--   -- first function changes the default setup handler
		--   function(server, opts) require("lspconfig")[server].setup(opts) end,
		--   -- keys for a specific server name will be used for that LSP
		--   sumneko_lua = function(server, opts)
		--     -- custom sumneko_lua setup handler
		--     require("lspconfig")["sumneko_lua"].setup(opts)
		--   end,
		-- },

		-- Add overrides for LSP server settings, the keys are the name of the server
		config = {
			-- example for addings schemas to yamlls
			-- yamlls = { -- override table for require("lspconfig").yamlls.setup({...})
			--   settings = {
			--     yaml = {
			--       schemas = {
			--         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
			--         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
			--         ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
			--       },
			--     },
			--   },
			-- },
		},
	},

	-- Mapping data with "desc" stored directly by vim.keymap.set().
	--
	-- Please use this mappings table to set keyboard mapping since this is the
	-- lower level configuration and more robust one. (which-key will
	-- automatically pick-up stored data by this setting.)
	mappings = {
		-- first key is the mode
		n = {
			-- second key is the lefthand side of the map
			-- mappings seen under group name "Buffer"
			-- TODO: Remove these bindings since they don't work in astro 3.x
			-- anyways as of NOW
			["<leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
			["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick to close" },
			["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
			["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },

			-- quick save
			-- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
			["<leader>fs"] = {
				"<cmd>Telescope lsp_workspace_symbols<cr>",
				desc = "Search and preview workspace symbols provided by LSP",
			},
			["<leader>fa"] = {
				"<cmd>Telescope commands<cr>",
				desc = "Search commands (like the command palette?)",
			},

			["<F60>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },

			-- Tabs with H/L
			["H"] = { "[b", desc = "Previous buffer", remap = true },
			["L"] = { "]b", desc = "Next buffer", remap = true },

			-- Tabs with alt-arrows
			["<M-Left>"] = { "[b", desc = "Previous buffer", remap = true },
			["<M-Right>"] = { "]b", desc = "Next buffer", remap = true },
		},
		t = {
			-- setting a mapping to false will disable it
			-- ["<esc>"] = false,
			["<F60>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
		},
	},

	-- Configure plugins
	plugins = {
		-- You can disable default plugins as follows:
		-- { "max397574/better-escape.nvim", enabled = false },
		--
		-- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
		-- {
		--   "L3MON4D3/LuaSnip",
		--   config = function(plugin, opts)
		--     plugin.default_config(opts) -- include the default astronvim config that calls the setup call
		--     -- add more custom luasnip configuration such as filetype extend or custom snippets
		--     local luasnip = require "luasnip"
		--     luasnip.filetype_extend("javascript", { "javascriptreact" })
		--   end,
		-- },
		-- {
		--   "windwp/nvim-autopairs",
		--   config = function(plugin, opts)
		--     plugin.default_config(opts) -- include the default astronvim config that calls the setup call
		--     -- add more custom autopairs configuration such as custom rules
		--     local npairs = require "nvim-autopairs"
		--     local Rule = require "nvim-autopairs.rule"
		--     local cond = require "nvim-autopairs.conds"
		--     npairs.add_rules(
		--       {
		--         Rule("$", "$", { "tex", "latex" })
		--           -- don't add a pair if the next character is %
		--           :with_pair(cond.not_after_regex "%%")
		--           -- don't add a pair if  the previous character is xxx
		--           :with_pair(
		--             cond.not_before_regex("xxx", 3)
		--           )
		--           -- don't move right when repeat character
		--           :with_move(cond.none())
		--           -- don't delete if the next character is xx
		--           :with_del(cond.not_after_regex "xx")
		--           -- disable adding a newline when you press <cr>
		--           :with_cr(cond.none()),
		--       },
		--       -- disable for .vim files, but it work for another filetypes
		--       Rule("a", "a", "-vim")
		--     )
		--   end,
		-- },
		-- By adding to the which-key config and using our helper function you can add more which-key registered bindings
		-- {
		--   "folke/which-key.nvim",
		--   config = function(plugin, opts)
		--     plugin.default_config(opts)
		--     -- Add bindings which show up as group name
		--     local wk = require "which-key"
		--     wk.register({
		--       b = { name = "Buffer" },
		--     }, { mode = "n", prefix = "<leader>" })
		--   end,
		-- },

		-- You can also add new plugins here as well:
		-- Add plugins, the lazy syntax
		-- "andweeb/presence.nvim",
		-- {
		--   "ray-x/lsp_signature.nvim",
		--   event = "BufRead",
		--   config = function()
		--     require("lsp_signature").setup()
		--   end,
		-- },

		-- Plugin entries can also be used to override the default options for plugins as well
		{
			"goolord/alpha-nvim",
			opts = function(_, opts)
				-- customize the dashboard header
				opts.section.header.val = {
					" █████  ███████ ████████ ██████   ██████",
					"██   ██ ██         ██    ██   ██ ██    ██",
					"███████ ███████    ██    ██████  ██    ██",
					"██   ██      ██    ██    ██   ██ ██    ██",
					"██   ██ ███████    ██    ██   ██  ██████",
					" ",
					"    ███    ██ ██    ██ ██ ███    ███",
					"    ████   ██ ██    ██ ██ ████  ████",
					"    ██ ██  ██ ██    ██ ██ ██ ████ ██",
					"    ██  ██ ██  ██  ██  ██ ██  ██  ██",
					"    ██   ████   ████   ██ ██      ██",
				}
				return opts
			end,
		},
		{
			"jose-elias-alvarez/null-ls.nvim",
			opts = function(_, config)
				-- config variable is the default configuration table for the setup function call
				-- local null_ls = require "null-ls"

				-- Check supported formatters and linters
				-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
				-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
				config.sources = {
					-- Set a formatter
					-- null_ls.builtins.formatting.stylua,
					-- null_ls.builtins.formatting.prettier,
				}
				return config -- return final config table
			end,
		},
		{
			"nvim-treesitter/nvim-treesitter",
			opts = {
				-- ensure_installed = { "lua" },
			},
		},
		-- use mason-lspconfig to configure LSP installations
		{
			"williamboman/mason-lspconfig.nvim",
			-- overrides `require("mason-lspconfig").setup(...)`
			opts = {
				-- ensure_installed = { "sumneko_lua" },
			},
		},
		-- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
		{
			"jay-babu/mason-null-ls.nvim",
			-- overrides `require("mason-null-ls").setup(...)`
			opts = {
				-- ensure_installed = { "prettier", "stylua" },
			},
		},
		{
			"jay-babu/mason-nvim-dap.nvim",
			-- overrides `require("mason-nvim-dap").setup(...)`
			opts = {
				-- ensure_installed = { "python" },
			},
		},
		-- Motions and actions
		{
			"kylechui/nvim-surround",
			config = function()
				require("nvim-surround").setup({
					-- Configuration here, or leave empty to use defaults
				})
			end,
			event = "BufRead",
		},
		{
			"easymotion/vim-easymotion",
			disabled = true,
		},
		{
			"phaazon/hop.nvim",
			config = function()
				require("hop").setup()
			end,
		},
		{
			"justinmk/vim-sneak",
			event = "BufRead",
		},
		-- Visual
		{
			"Djancyp/better-comments.nvim",
			config = function()
				require("better-comment").Setup()
			end,
			event = "VeryLazy",
		},
		{
			"tummetott/reticle.nvim",
			event = "VeryLazy",
			config = function()
				require("reticle").setup()
			end,
		},
		{
			"psliwka/vim-smoothie",
			event = "VeryLazy",
		},
		-- Code-intelligence
		{
			"stevearc/aerial.nvim",
			config = function()
				require("aerial").setup({
					attach_mode = "global",
					backends = { "lsp", "treesitter", "markdown", "man" },
					layout = { min_width = 28, placement = "edge", default_direction = "prefer_left" },
					show_guides = true,
					filter_kind = false,
					guides = {
						mid_item = "├ ",
						last_item = "└ ",
						nested_top = "│ ",
						whitespace = "  ",
					},
					keymaps = {
						["[y"] = "actions.prev",
						["]y"] = "actions.next",
						["[Y"] = "actions.prev_up",
						["]Y"] = "actions.next_up",
						["{"] = false,
						["}"] = false,
						["[["] = false,
						["]]"] = false,
					},
				})
			end,
		},
		{
			-- Show code context (function, etc) on top while navigating ala context.vim
			"nvim-treesitter/nvim-treesitter-context",
			event = "BufReadPost",
			dependencies = {
				"treesitter",
			},
			config = function()
				require("treesitter-context").setup()
			end,
		},
		-- Utility and tracking
		{
			"wakatime/vim-wakatime",
			event = "VeryLazy",
		},
		-- AI assist
		{
			"zbirenbaum/copilot.lua",
			cmd = "Copilot",
			event = "VimEnter",
			config = function()
				vim.defer_fn(function()
					require("copilot").setup()
				end, 100)
			end,
		},
		{
			"zbirenbaum/copilot-cmp",
		},
		-- ############# -- ############# --
		-- Navigation -- ########### -----------
		-- ############# -- ############# --

		-- TODO: fix up
		["nvim-neo-tree/neo-tree.nvim"] = {
			config = function()
				require("neo-tree").setup({
					window = {
						position = "right",
					},
				})
			end,
		},
		{
			"ThePrimeagen/harpoon",
			event = "VeryLazy",
		},
		{
			"nvim-treesitter/playground",
		},

		-- ############# -- ############# --
		-- THEMES -- ########### -----------
		-- ############# -- ############# --
		{
			"folke/tokyonight.nvim",
			event = "VeryLazy",
		},
		{
			"jesseleite/nvim-noirbuddy",
			event = "VeryLazy",
			dependencies = {
				"tjdevries/colorbuddy.nvim",
				branch = "dev",
			},
		},
		{
			"nyoom-engineering/oxocarbon.nvim",
			event = "VeryLazy",
		},
		{
			-- So cool!
			"bluz71/vim-moonfly-colors",
			event = "VeryLazy",
		},
		{
			"bluz71/vim-nightfly-colors",
			event = "VeryLazy",
		},
		{
			"Everblush/nvim",
			event = "VeryLazy",
		},
		{
			"rockerBOO/boo-colorscheme-nvim",
			event = "VeryLazy",
		},
		{
			"lalitmee/cobalt2.nvim",
			event = "VeryLazy",
		},
		{
			"phha/zenburn.nvim",
			event = "VeryLazy",
		},
		{
			"JoosepAlviste/palenightfall.nvim",
			event = "VeryLazy",
		},
		{
			"yonlu/omni.vim",
			event = "VeryLazy",
		},
		{
			"lighthaus-theme/vim-lighthaus",
			event = "VeryLazy",
		},
		{
			"Abstract-IDE/Abstract-cs",
			event = "VeryLazy",
		},
		{
			"Mofiqul/dracula.nvim",
			event = "VeryLazy",
		},
		{
			"mcchrish/zenbones.nvim",
			event = "VeryLazy",
			dependencies = {
				"rktjmp/lush.nvim",
			},
		},
		{
			"LunarVim/horizon.nvim",
			event = "VeryLazy",
		},
		{
			"LunarVim/synthwave84.nvim",
			event = "VeryLazy",
		},
		{
			"katawful/kat.nvim",
			event = "VeryLazy",
		},
	},

	-- LuaSnip Options
	luasnip = {
		-- Extend filetypes
		filetype_extend = {
			-- javascript = { "javascriptreact" },
		},
		-- Configure luasnip loaders (vscode, lua, and/or snipmate)
		vscode = {
			-- Add paths for including more VS Code style snippets in luasnip
			paths = {},
		},
	},

	-- CMP Source Priorities
	-- modify here the priorities of default cmp sources
	-- higher value == higher priority
	-- The value can also be set to a boolean for disabling default sources:
	-- false == disabled
	-- true == 1000
	cmp = {
		source_priority = {
			nvim_lsp = 1000,
			luasnip = 750,
			buffer = 500,
			path = 250,
		},
	},

	-- Customize Heirline options
	heirline = {
		-- -- Customize different separators between sections
		-- separators = {
		--   tab = { "", "" },
		-- },
		-- -- Customize colors for each element each element has a `_fg` and a `_bg`
		-- colors = function(colors)
		--   colors.git_branch_fg = astronvim.get_hlgroup "Conditional"
		--   return colors
		-- end,
		-- -- Customize attributes of highlighting in Heirline components
		-- attributes = {
		--   -- styling choices for each heirline element, check possible attributes with `:h attr-list`
		--   git_branch = { bold = true }, -- bold the git branch statusline component
		-- },
		-- -- Customize if icons should be highlighted
		-- icon_highlights = {
		--   breadcrumbs = false, -- LSP symbols in the breadcrumbs
		--   file_icon = {
		--     winbar = false, -- Filetype icon in the winbar inactive windows
		--     statusline = true, -- Filetype icon in the statusline
		--   },
		-- },
	},

	-- Modify which-key registration (Use this with mappings table in the above.)
	["which-key"] = {
		-- Add bindings which show up as group name
		register = {
			-- first key is the mode, n == normal mode
			n = {
				-- second key is the prefix, <leader> prefixes
				["<leader>"] = {
					-- third key is the key to bring up next level and its displayed
					-- group name in which-key top level menu
					["b"] = { name = "Buffer" },
				},
			},
		},
	},

	-- This function is run last and is a good place to configuring
	-- augroups/autocommands and custom filetypes also this just pure lua so
	-- anything that doesn't fit in the normal config locations above can go here
	polish = function()
		-- Set up custom filetypes
		-- vim.filetype.add {
		--   extension = {
		--     foo = "fooscript",
		--   },
		--   filename = {
		--     ["Foofile"] = "fooscript",
		--   },
		--   pattern = {
		--     ["~/%.config/foo/.*"] = "fooscript",
		--   },
		-- }
		--
		-- vim.cmd('colorscheme astrodark')
		vim.cmd("source " .. "~/.vimrc")
		vim.cmd.colorscheme("oxocarbon")
		vim.keymap.set("i", "<M-CR>", "copilot#Accept(<Tab>)", { silent = true, expr = true, script = true })
		-- reticle disables columncursor on inactive splits. setup() here because it needs opt to be enabled
		-- require("reticle").setup()
	end,
}

return config
