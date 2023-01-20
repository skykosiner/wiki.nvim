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

---@param file string
function utils.edit(file)
  vim.api.nvim_input(string.format(":e %s<CR>", file))
end

return utils
