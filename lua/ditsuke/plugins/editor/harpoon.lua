-- Jump between files and terminals
return {
  "ThePrimeagen/harpoon",
  event = "VeryLazy",
  keys = {
    { "<leader>a", function() require("harpoon.mark").add_file() end, desc = "Harpoon: [m]ark file" },
    { "<C-A>", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon: toggle quick menu" },
    { "<Tab>", function() require("harpoon.ui").nav_next() end, desc = "Harpoon: Nav next" },
    { "<S-Tab>", function() require("harpoon.ui").nav_prev() end, desc = "Harpoon: Nav prev" },
  },
}
