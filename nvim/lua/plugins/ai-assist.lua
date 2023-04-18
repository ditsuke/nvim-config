return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "VeryLazy",
    config = true,
  },
  -- TODO: try hooking this up
  {
    "zbirenbaum/copilot-cmp",
  },
  {
    "jackMort/ChatGPT.nvim",
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
  {
    "james1236/backseat.nvim",
    opts = {
      openai_model_id = "gpt-3.5-turbo",
    },
  },
}
