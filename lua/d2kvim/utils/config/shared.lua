local M = {}

local async = require("plenary.async")
local Job = require("plenary.job")

M.NON_LSP_CLIENTS = { "", "copilot", "null-ls", "luasnip" }

local LOG_FILE_PATH = "./log_nvim.txt"
local log_file = io.open(LOG_FILE_PATH, "a")
local log_count = 0

M.sampled_logger = function(message, payload)
  log_count = log_count + 1
  if log_count == 30 then
    log_count = 0
    M.logger(message, payload)
  end
end

M.logger = function(message, payload)
  if log_file == nil then return end
  if payload ~= nil then
    M.logger("payload passed to our logger")
    message = message .. vim.inspect(payload)
  end
  io.output(log_file)
  io.write(message .. "\n\n")
end

M.set_window_title = function()
  local path = vim.split(vim.fn.getcwd(), "/", {})
  vim.opt.titlestring = [[%{v:progname}: ]] .. vim.fn.join({ path[#path - 1], path[#path] }, "/")
  vim.opt.title = true
end

M.get_active_lsp = function()
  for _, client in ipairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
    if not vim.tbl_contains(M.NON_LSP_CLIENTS, client.name) then return client.name end
  end
  return nil
end

M.get_wakatime_time = function()
  local tx, rx = async.control.channel.oneshot()
  local ok, job = pcall(Job.new, Job, {
    command = os.getenv("HOME") .. "/.wakatime/wakatime-cli",
    args = { "--today" },
    on_exit = function(j, _) tx(j:result()[1] or "") end,
  })
  if not ok then
    print("Bad WakaTime call: " .. job)
    return ""
  end

  -- if data then return "🅆  " .. data:sub(1, #data - 2) .. " " end
  job:start()
  return rx()
end

return M
