local M = {}

-- Insert values into a list if they don't already exist
---@param list string[]
---@param vals string|string[]
function M.list_insert_unique(list, vals)
  list = list or {}
  if type(vals) ~= "table" then vals = { vals } end
  for _, val in ipairs(vals) do
    if not vim.tbl_contains(list, val) then table.insert(list, val) end
  end
end

return M
