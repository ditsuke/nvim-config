-- Harpoon 2, retaining our file navigation bindings.
return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = { settings = { save_on_toggle = true } },
  keys = {
    { "<leader>a", function() require("harpoon"):list():add() end, desc = "Harpoon: mark file" },
    {
      "<C-A>",
      function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = "Harpoon: toggle quick menu",
    },
    { "<Tab>", function() require("harpoon"):list():next() end, desc = "Harpoon: Nav next" },
    { "<S-Tab>", function() require("harpoon"):list():prev() end, desc = "Harpoon: Nav prev" },
  },
}
