local M = {}

M.setTitle = function()
M.NON_LSP_CLIENTS = { "", "copilot", "null-ls", "luasnip" }

M.set_window_title = function()
  local path = vim.split(vim.fn.getcwd(), "/", {})
  vim.opt.titlestring = [[%{v:progname}: ]] .. vim.fn.join({ path[#path - 1], path[#path] }, "/")
  vim.opt.title = true
end

M.get_active_lsp = function()
  for _, client in ipairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
    if not vim.tbl_contains(M.NON_LSP_CLIENTS, client.name) then
      return client.name
    end
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
