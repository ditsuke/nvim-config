return {
  -- > Fully featured & enhanced replacement for copilot.vim complete with API for interacting with Github Copilot
  {
    "zbirenbaum/copilot.lua",
    enabled = true,
    event = "InsertEnter",
    cmd = "Copilot",
    dependencies = {
      -- TODO: try hooking this up
      {
        "zbirenbaum/copilot-cmp",
      },
    },
    opts = {
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<M-;>",
          accept_line = "<M-l>",
          accept_word = "<M-,>",
        },
      },
      filetypes = {
        -- Enable Copilot in markdown files (default: false)
        markdown = true,
      },
    },
  },
  {
    "sourcegraph/sg.nvim",
    enabled = false,
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- > ChatGPT is a Neovim plugin that allows you to interact with OpenAI's GPT-3 language model.
  -- > With ChatGPT, you can ask questions and get answers from GPT-3 in real-time.
  {
    "jackMort/ChatGPT.nvim",
    cmd = "ChatGPT",
    config = true,
    cond = function()
      local api_key = os.getenv("OPENAI_API_KEY")
      return api_key and api_key ~= "" and true or false
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },

  --  > A neovim plugin that uses GPT to highlight and explain code readability issues
  --  Use with :Backseat<Tab>
  {
    "james1236/backseat.nvim",
    enabled = false,
    opts = {
      openai_model_id = "gpt-3.5-turbo",
    },
  },
  {
    "supermaven-inc/supermaven-nvim",
    enabled = false,
    opts = {
      keymaps = {
        accept_suggestion = "<M-;>",
        accept_word = "<M-k>",
      },
    },
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    enabled = false,
    lazy = false,
    version = false, -- set this to "*" if you want to always pull the latest change, false to update on release
    ---@type avante.CoreConfig
    opts = {
      provider = "openai",
      auto_suggestions_provider = "openai",
      openai = {
        endpoint = "https://api.deepseek.com/v1",
        model = "deepseek-coder",
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
}
