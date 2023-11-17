-- Make sure colorschemes are loaded on VeryLazy (we want them to be
-- loaded for previews)
local function build_colorscheme_spec(colorschemes)
  return vim.tbl_map(function(colorscheme)
    local fqn = type(colorscheme) == "string" and colorscheme or colorscheme[1]
    local spec =
      vim.tbl_extend("force", { fqn, event = "VeryLazy" }, type(colorscheme) == "table" and colorscheme or {})
    return spec
  end, colorschemes)
end

local colorschemes = {
  -- Clean and popular
  -- > A clean, dark Neovim theme written in Lua, with support for
  -- > lsp, treesitter and lots of plugins.
  "folke/tokyonight.nvim",

  -- One of my favorites
  -- > A dark and light Neovim theme written in fennel, inspired by IBM Carbon.
  "nyoom-engineering/oxocarbon.nvim",

  -- Really cool
  -- > A dark charcoal theme for modern Neovim & classic Vim
  "bluz71/vim-moonfly-colors",
  "bluz71/vim-nightfly-colors",
  "Everblush/nvim",
  "JoosepAlviste/palenightfall.nvim",
  "yonlu/omni.vim",
  "Abstract-IDE/Abstract-cs",
  "Mofiqul/dracula.nvim",
  "LunarVim/horizon.nvim",

  -- > Port of the original
  -- >> A Synthwave inspired colour theme (for VSCode)
  -- >> Source: https://github.com/robb0wen/synthwave-vscode
  "LunarVim/synthwave84.nvim",
  "katawful/kat.nvim",
  "hachy/eva01.vim",
  "igorgue/danger",

  -- > NeoVim dark colorscheme inspired by the colors of the famous painting by Katsushika Hokusai
  "rebelot/kanagawa.nvim",

  -- > Moonbow is a theme for nvim inspired by Gruvbox and Ayu dark
  "arturgoms/moonbow.nvim",

  -- > 🪨 A collection of contrast-based Vim/Neovim colorschemes
  { "mcchrish/zenbones.nvim", dependencies = "rktjmp/lush.nvim" },

  -- > 🍨 Soothing pastel theme for (Neo)vim
  { "catppuccin/nvim", name = "catppuccin" },

  -- > All natural pine, faux fur and a bit of soho vibes for the classy minimalist
  { "rose-pine/neovim", name = "rose-pine" },
  { "ellisonleao/gruvbox.nvim", opts = { palette_overrides = {} } },

  -- Tons of awesome color schemes in base16. Really nice!
  "RRethy/nvim-base16",

  { "scysta/pink-panic.nvim", dependencies = "rktjmp/lush.nvim" },

  {
    "jesseleite/nvim-noirbuddy",
    dependencies = { "tjdevries/colorbuddy.nvim", branch = "dev" },
  },

  {
    "maxmx03/fluoromachine.nvim",
    -- Setting these also enables the colorscheme. Poor
    -- opts = {
    --   -- glow = true,
    -- },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function(_, opts)
      local theme = require("catppuccin")
      theme.setup(opts)
      -- vim.cmd([[colorscheme catppuccin]])
    end,
    opts = function()
      local Color = require("helpers.color")
      local overrides = function(lighten, darken)
        local function override(colors)
          local fg_border = lighten(colors.base, 3)
          local telescope_prompt = darken(colors.base, 3)
          local telescope_results = darken(colors.base, 4)
          local telescope_preview = darken(colors.base, 6)
          local telescope_selection = darken(colors.base, 8)
          local faded_yellow = Color.mix(colors.base, colors.yellow, 0.1)
          local faded_red = Color.mix(colors.base, colors.red, 0.1)
          local faded_purple = Color.mix(colors.base, colors.mauve, 0.1)

          local gray = colors.subtext0
          local fg = colors.text
          local purple = colors.mauve
          local green = colors.green
          local blue = colors.blue
          local yellow = colors.yellow
          local red = colors.red
          local cyan = colors.sky
          local float_bg = colors.mantle

          return {
            IndentBlanklineContextChar = { fg = colors.surface1 },
            IndentBlanklineChar = { fg = colors.surface1 },

            TelescopeBorder = {
              fg = telescope_results,
              bg = telescope_results,
            },
            TelescopePromptBorder = {
              fg = telescope_prompt,
              bg = telescope_prompt,
            },
            TelescopePromptCounter = { fg = fg },
            TelescopePromptNormal = { fg = fg, bg = telescope_prompt },
            TelescopePromptPrefix = {
              fg = purple,
              bg = telescope_prompt,
            },
            TelescopePromptTitle = {
              fg = telescope_prompt,
              bg = purple,
            },
            TelescopePreviewTitle = {
              fg = telescope_results,
              bg = green,
            },
            TelescopeResultsTitle = {
              fg = telescope_results,
              bg = telescope_results,
            },
            TelescopeMatching = { fg = blue },
            TelescopeNormal = { bg = telescope_results },
            TelescopeSelection = { bg = telescope_selection },
            TelescopePreviewNormal = { bg = telescope_preview },
            TelescopePreviewBorder = { fg = telescope_preview, bg = telescope_preview },

            NeoTreeTabActive = { bg = colors.mantle, bold = true },
            NeoTreeTabSeparatorActive = { fg = colors.mantle, bg = colors.mantle },
            NeoTreeTabInactive = { bg = colors.mantle, fg = colors.overlay0 },
            NeoTreeTabSeparatorInactive = { fg = colors.mantle, bg = colors.mantle },
            NeoTreeNormal = { fg = colors.text, bg = colors.mantle },
            NeoTreeNormalNC = { fg = colors.text, bg = colors.mantle },

            LineNr = { fg = colors.overlay0, bold = true },
            CursorLineNr = { fg = colors.lavender, bold = true },
            -- Cmp
            CmpItemAbbrMatch = { fg = blue, bold = true },
            CmpItemAbbrMatchFuzzy = { fg = blue, underline = true },
            CmpItemMenu = { fg = colors.surface1, italic = true },
            -- CmpItemAbbr = { fg = colors.surface2 },

            -- Neotest
            NeotestAdapterName = { fg = purple, bold = true },
            NeotestFocused = { bold = true },
            NeotestNamespace = { fg = blue, bold = true },

            -- Neotree
            NeoTreeRootName = { fg = purple, bold = true },
            NeoTreeFileNameOpened = { fg = purple, italic = true },

            -- DAP
            -- DebugBreakpoint = { fg = "${red}", bold = true },
            -- DebugHighlightLine = { fg = "${purple}", italic = true },
            NvimDapVirtualText = { fg = cyan, italic = true },

            -- DAP UI
            DapUIBreakpointsCurrentLine = { fg = yellow, bold = true },

            DiagnosticUnderlineError = { sp = red, undercurl = true },
            DiagnosticUnderlineWarn = { sp = yellow, undercurl = true },
            DiagnosticUnderlineInfo = { sp = blue, undercurl = true },
            DiagnosticUnderlineHint = { sp = cyan, undercurl = true },

            DiagnosticFloatingSuffix = { fg = gray },
            DiagnosticFloatingHint = { fg = fg },
            DiagnosticFloatingWarn = { fg = fg },
            DiagnosticFloatingInfo = { fg = fg },
            DiagnosticFloatingError = { fg = fg },

            -- ModeMsg = { fg = "${fg}", bg = "${telescope_prompt}" },
            NoiceMini = { link = "NonText" },
            NoiceVirtualText = { link = "NonText" },
            NoiceCmdlinePopup = { link = "PopupNormal" },
            NoiceCmdlinePopupBorder = { link = "PopupBorder" },
            NoiceCmdlinePrompt = { link = "PopupNormal" },
            NoiceConfirm = { link = "PopupNormal" },
            NoiceConfirmBorder = { link = "PopupBorder" },

            AIHighlight = { link = "NonText" },
            AIIndicator = { link = "DiagnosticSignInfo" },

            PopupNormal = { bg = float_bg },
            PopupBorder = { bg = float_bg, fg = fg_border },
            Pmenu = { link = "PopupNormal" },
            PmenuSel = { bold = true, bg = "none" },
            PmenuBorder = { link = "PopupBorder" },
            PmenuDocBorder = { bg = float_bg, fg = fg_border },
            NormalFloat = { bg = float_bg },
            FloatBorder = { bg = float_bg, fg = fg_border },
            FloatTitle = { fg = colors.lavender, bg = float_bg },
            BqfPreviewBorder = { link = "PopupBorder" },
            BqfPreviewFloat = { link = "PopupNormal" },

            DebugLogPoint = { fg = purple, bg = faded_purple },
            DebugLogPointLine = { bg = faded_purple },
            DebugStopped = { fg = yellow, bg = faded_yellow },
            DebugStoppedLine = { bg = faded_yellow },
            DebugBreakpoint = { fg = red, bg = faded_red },
            DebugBreakpointLine = { bg = faded_red },
            WinSeparator = { fg = colors.mantle, bg = colors.mantle },
            StatusColumnSeparator = { fg = colors.surface2, bg = "none" },

            TabLineHead = { bg = blue, fg = colors.base },
            TabLineFill = { bg = colors.mantle, fg = gray },
            TabLine = { bg = colors.mantle, fg = gray },
            TabLineSel = { bg = colors.mantle, fg = fg, bold = true },

            NotifyERRORBorder = { link = "PopupBorder" },
            NotifyWARNBorder = { link = "PopupBorder" },
            NotifyINFOBorder = { link = "PopupBorder" },
            NotifyDEBUGBorder = { link = "PopupBorder" },
            NotifyTRACEBorder = { link = "PopupBorder" },
            NotifyERRORIcon = { link = "DiagnosticSignError" },
            NotifyWARNIcon = { link = "DiagnosticSignWarn" },
            NotifyINFOIcon = { link = "DiagnosticSignInfo" },
            NotifyDEBUGIcon = { link = "DiagnosticSignInfo" },
            NotifyTRACEIcon = { link = "DiagnosticSignInfo" },
            NotifyERRORTitle = { fg = colors.text, bold = true },
            NotifyWARNTitle = { fg = colors.text, bold = true },
            NotifyINFOTitle = { fg = colors.text, bold = true },
            NotifyDEBUGTitle = { fg = colors.text, bold = true },
            NotifyTRACETitle = { fg = colors.text, bold = true },
            NotifyERRORBody = { link = "NormalFloat" },
            NotifyWARNBody = { link = "NormalFloat" },
            NotifyINFOBody = { link = "NormalFloat" },
            NotifyDEBUGBody = { link = "NormalFloat" },
            NotifyTRACEBody = { link = "NormalFloat" },
          }
        end
        return override
      end

      return {
        flavour = "macchiato", -- latte, frappe, macchiato, mocha
        background = { -- :h background
          light = "latte",
          dark = "macchiato",
        },
        transparent_background = false,
        dim_inactive = {
          enabled = false,
          shade = "dark",
          percentage = 0.15,
        },
        show_end_of_buffer = false, -- show the '~' characters after the end of buffers
        term_colors = true,
        styles = {
          comments = { "italic" },
          conditionals = {},
          loops = {},
          functions = { "bold" },
          keywords = { "bold" },
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = { "bold" },
          operators = {},
        },
        color_overrides = {},
        highlight_overrides = {
          mocha = overrides(Color.lighten, Color.darken),
          macchiato = overrides(Color.lighten, Color.darken),
          frappe = overrides(Color.lighten, Color.darken),
          latte = overrides(Color.darken, Color.darken),
        },
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          telescope = true,
          notify = false,
          mini = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
          },
        },
      }
    end,
  },
  "decaycs/decay.nvim",
  "projekt0n/github-nvim-theme",
  -- Soothing green colorscheme, very nice!
  "ribru17/bamboo.nvim",
  -- > [WIP] The timeless colorscheme for neovim text editor.
  "projekt0n/caret.nvim",
  {
    "svermeulen/text-to-colorscheme",
    opts = {
      default_palette = "sakura-glasgow-darker",
      ai = {
        openai_api_key = os.getenv("OPENAI_API_KEY"),
        gpt_model = "gpt-3.5-turbo-0613",
      },
      hex_palettes = {
        {
          name = "sakura-glasgow",
          background_mode = "dark",
          background = "#0b0b0b",
          foreground = "#ffffff",
          accents = {
            "#ffb8ca",
            "#ffd9b8",
            "#fff0b8",
            "#d9ffb8",
            "#b8ffcd",
            "#b8fff0",
            "#b8d9ff",
          },
        },
        {
          name = "sakura-glasgow-darker",
          background_mode = "dark",
          background = "#120f0f",
          foreground = "#e2b5b5",
          accents = {
            "#e2cc76",
            "#e2a876",
            "#76e296",
            "#a8e276",
            "#76e2cc",
            "#76a8e2",
            "#e27691",
          },
        },
      },
    },
  },
  "zootedb0t/citruszest.nvim",
}

return {
  build_colorscheme_spec(colorschemes),

  -- Effortlessly sync the terminal background with Neovim.
  -- As a side effect, get effortless transparency across color schemes!
  { "typicode/bg.nvim", lazy = false, cond = function() return os.getenv("NVIM_COLORSYNC") ~= nil end },

  -- Configure LazyVim to load oxocarbon
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "bamboo",
    },
  },
}
