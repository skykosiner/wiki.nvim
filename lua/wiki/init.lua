local wiki = {}

function wiki.setup(path)
  -- Set the path where all the notes will be stored
  vim.g.notesDir = path or string.format("%s/notes", os.getenv("HOME"))
end

return wiki
