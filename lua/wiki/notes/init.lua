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
  -- Get's the current filename trims off the .md suffix
  local currentNoteName = string.gsub(vim.fn.expand("%:t"), string.format(".%s", vim.fn.expand("%:e")), "")
  -- Grep each file in the current dir for the string [[note-name]] in order to find all the links
  require("telescope.builtin").grep_string({ search = string.format("[[%s]]", currentNoteName) })
end

function notes.find_link_file()
  local file = string.format("%s.md", vim.fn.expand("<cword>"))
  -- Get the path to the where the file of the current word is
  local notePath = vim.fn.systemlist(string.format("find . -path '*%s'", file))[1]

  -- Create the note if it does not exist and then jump to it
  if notePath == nil then
    -- Use the || not the && incase the dir is already made so that it will just ignore the error.
    -- As the && syntax makes sure both don't error, and if the dir already exists mkdir will error
    os.execute(string.format("mkdir %s/misc 2> /dev/null || touch %s/misc/%s", vim.g.notesDir, vim.g.notesDir, file))
    notePath = vim.fn.systemlist(string.format("find . -path '*%s'", file))[1]
  end

  vim.cmd("e " .. notePath)

end

function notes.move_note_to_different_dir()
  local currentNotePath = vim.fn.expand("%:p")
  local currentNoteName = vim.fn.expand("%:t")
  local subDirsOfMainNoteDir = vim.fn.systemlist("find . -type d")

  require("telescope.pickers").new({}, {
    prompt_title = "< Move to dir? >",
    finder = require("telescope.finders").new_table({
      results = subDirsOfMainNoteDir
    }),
    sorter = require("telescope.config").values.generic_sorter({}),
    attach_mappings = function(_, map)
      map("i", "<CR>", function(prompt_bufnr)
        local content = require("telescope.actions.state").get_selected_entry(
          prompt_bufnr
        )

        require("telescope.actions").close(prompt_bufnr)
        content.value = string.gsub(content.value, "^./", "")
        local newPath = string.format("%s/%s", vim.g.notesDir, content.value)
        os.execute(string.format("mv %s %s", currentNotePath, newPath))
        -- Open the note in the new path
        vim.cmd(string.format("e %s/%s", newPath, currentNoteName))
      end)
      return true
    end,
  }):find()
end

return notes
