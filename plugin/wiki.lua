-- Make sure the user has at least nvim version 7 installed on there system
if 1 ~= vim.fn.has "nvim-0.7.0" then
  vim.api.nvim_err_writeln("Wiki.nvim requires at least nvim-0.7.0")
  return
end

local group = vim.api.nvim_create_augroup("WIKI", { clear = true })

-- Make sure to set the type of the file to markdown, so we get sweet syntax highlights
vim.api.nvim_create_autocmd("BufWinEnter", { pattern = "*.notes", callback = function()
  vim.opt_local.filetype = "markdown"
end, group = group })
