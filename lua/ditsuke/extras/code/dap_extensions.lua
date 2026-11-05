local dap = {
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
    { "<leader>dP", function() require("dap").pause() end, desc = "Pause" },
    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    { "<leader>ds", function() require("dap").session() end, desc = "Session" },
    { "<F17>", function() require("dap").terminate() end, desc = "Terminate" },
    { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
  },
}

-- Transform inherited keys as well as our custom bindings.
local function move_debug_keys(_, keys)
  for _, key in ipairs(keys) do
    key[1] = key[1]:gsub("^<leader>d", "<leader>D")
  end
  return keys
end

local custom_keys = dap.keys
dap.keys = function(plugin, keys)
  vim.list_extend(keys, vim.deepcopy(custom_keys))
  return move_debug_keys(plugin, keys)
end

return {
  dap,
  { "rcarriga/nvim-dap-ui", keys = move_debug_keys },
  { "mfussenegger/nvim-dap-python", optional = true, keys = move_debug_keys },
  {
    "folke/snacks.nvim",
    keys = move_debug_keys,
    init = function()
      -- These toggles are installed by LazyVim outside the plugin key specs.
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimKeymaps",
        group = vim.api.nvim_create_augroup("ditsuke_debug_keymaps", { clear = true }),
        callback = function()
          vim.keymap.del("n", "<leader>dpp")
          vim.keymap.del("n", "<leader>dph")
          Snacks.toggle.profiler():map("<leader>Dpp")
          Snacks.toggle.profiler_highlights():map("<leader>Dph")
        end,
      })
    end,
  },
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      local function move_groups(specs)
        for _, spec in ipairs(specs) do
          if type(spec) == "table" then
            if type(spec[1]) == "string" then
              spec[1] = spec[1]:gsub("^<leader>d", "<leader>D")
            end
            move_groups(spec)
          end
        end
      end
      move_groups(opts.spec or {})
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    optional = true,
    opts = function(_, opts)
      local on_attach = opts.server.on_attach
      opts.server.on_attach = function(client, bufnr)
        if on_attach then
          on_attach(client, bufnr)
        end
        pcall(vim.keymap.del, "n", "<leader>dr", { buffer = bufnr })
        vim.keymap.set("n", "<leader>Dr", function()
          vim.cmd.RustLsp("debuggables")
        end, { desc = "Rust Debuggables", buffer = bufnr })
      end
    end,
  },
}
