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
}
