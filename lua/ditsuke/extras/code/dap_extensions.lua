return {
  "mfussenegger/nvim-dap",

  -- IntelliJ-style DAP keymap
  -- Ref: https://www.jetbrains.com/help/idea/reference-keymap-win-default.html#run_debug
  keys = {
    -- stylua: ignore
    { "<F57>", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<F33>", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<F5>", function() require("dap").continue() end, desc = "Continue" },
    { "<F34>", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    { "<leader>dg", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
    { "<F11>", function() require("dap").step_into() end, desc = "Step Into" },
    { "<leader>dj", function() require("dap").down() end, desc = "Down" },
    { "<leader>dk", function() require("dap").up() end, desc = "Up" },
    { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
    { "<F23>", function() require("dap").step_out() end, desc = "Step Out" },
    { "<F10>", function() require("dap").step_over() end, desc = "Step Over" },
    { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    { "<leader>ds", function() require("dap").session() end, desc = "Session" },
    { "<F17>", function() require("dap").terminate() end, desc = "Terminate" },
    { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
  },
}
