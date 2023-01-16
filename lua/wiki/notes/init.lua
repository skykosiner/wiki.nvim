local notes = {}

local function CWD(subdir)
  if subdir then
    return string.format("%s/%s", vim.g.notesDir, subdir)
  else
    return vim.g.notesDir
  end

end

-- This works by just calling something like lua require("wiki.notes").search_notes()
-- In the () you put the directory you want to search for notes in if you don't want
-- no do the base dir. You can add more / to go deeper then one dir
function notes.search_notes(subdir)
  require("telescope.builtin").find_files({
    prompt_tile = "< Notes >",
    cwd = CWD(subdir),
    hidden = true
  })
end

function notes.find_links()
  -- Get's the current filename trims off the .notes suffix
  local currentNoteName = string.gsub(vim.fn.expand("%:t"), string.format(".%s", vim.fn.expand("%:e")), "")
  -- Grep each file in the current dir for the string [[note-name]] in order to find all the links
  require("telescope.builtin").grep_string({ search = string.format("[[%s]]", currentNoteName) })
end

function notes.find_link_file()
  local file = string.format("%s.md", vim.fn.expand("<cword>"))
  -- Get the path to the where the file of the current word is
  local notePath = vim.fn.systemlist(string.format("find . -path '*%s'", file))[1]

  vim.cmd("e " .. notePath)
end

return notes
