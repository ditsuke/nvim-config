local M = {}

local async = require("plenary.async")
local Job = require("plenary.job")

local LOG_FILE_PATH = "./nvim.local.log"
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
  if log_file == nil then
    return
  end
  if payload ~= nil then
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

-- Insert values into a list if they don't already exist
---@param list string[]
---@param vals string|string[]
function M.list_insert_unique(list, vals)
  list = list or {}
  if type(vals) ~= "table" then
    vals = { vals }
  end
  for _, val in ipairs(vals) do
    if not vim.tbl_contains(list, val) then
      table.insert(list, val)
    end
  end
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
