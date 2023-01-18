local utils = {}

---@param tbl table
---@return integer
function utils.tbl_len(tbl)
  local len = 0
  for _, _ in ipairs(tbl) do
    len = len + 1
  end

  return len
end

return utils
