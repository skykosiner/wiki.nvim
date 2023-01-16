local notes = {}

function notes.search_notes()
  require("telescope.builtin").find_files({
    prompt_tile = "< Notes >",
    cwd = vim.g.notesDir,
    hidden = true
  })
end

--[[
This works by just calling something like
lua require("wiki.notes").search_notes_subdir()
In the () you put the directory you want to search for notes in, if you add more slashes you can do deeper then one
--]]
function notes.search_notes_subdir(dir)
  require("telescope.builtin").find_files({
    prompt_tile = "< Notes >",
    cwd = string.format("%s/%s", vim.g.notesDir, dir),
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
  local currentWord = vim.fn.expand("<cword>")
end

return notes
