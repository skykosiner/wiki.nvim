-- Make sure the user has at least nvim version 7 installed on there system
if 1 ~= vim.fn.has("nvim-0.7.0") then
  vim.api.nvim_err_writeln("Wiki.nvim requires at least nvim-0.7.0")
  return
end

-- Make sure the user has telescope
local hasTelescope = pcall(require, "telescope")

if not hasTelescope then
  vim.api.nvim_err_writeln("Wiki.nvim requires telescope.nvim")
  return
end

-- Check that the convert file script existis in the path ~/.local/bin, and make sure the user has pandoc installed
local function is_windows()
  if package.config:sub(1, 1) == "\\" then
    return true
  end

  return false
end

if not is_windows() then
  local convertFileScript = [[
#!/usr/bin/env bash
path=$2
case $1 in
    "--pdf")
        pathPDF=$(echo $2 | sed s/md/pdf/)
        pandoc -f markdown -t pdf $2 > $pathPDF
        ;;
    # Apparently people use word documents???????????
    "--word")
        pathWord=$(echo $2 | sed s/md/docx/)
        pandoc -f markdown -t docx $2 > $pathWord
        ;;
    "--html")
        pathHTML=$(echo $2 | sed s/md/html/)
        pandoc -f markdown -t html $2 > $pathHTML
        ;;
    *) echo "Unavailable command... $curr"
esac
]]

  -- Check if the script exists under the name, convertNote
  local function file_exist(path)
    local f = io.open(path)
    if f ~= nil then
      io.close(f)
      return true
    else
      return false
    end
  end

  if not file_exist(string.format("%s/.local/bin/convertNote", os.getenv("HOME"))) then
    local file = io.open(string.format("%s/.local/bin/convertNote", os.getenv("HOME")), "w")

    if file ~= nil then
      file:write(convertFileScript)
      file:close()
      vim.fn.system(string.format("chmod +x %s/.local/bin/convertNote", os.getenv("HOME")))
    end
  end

  if not file_exist("/usr/bin/pandoc") then
    error("This plugin requires the use of pandoc")
  end
end
