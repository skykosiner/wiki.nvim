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
