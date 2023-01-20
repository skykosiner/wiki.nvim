**THIS IS NOT VIMWIKI NOR IS IT AS POWERFUL THIS IS A LITTLE TOOL I WROTE FOR MY SELF WITH ONLY THE FUNCTIONS I NEED**
# SORRY WINDOWS USERS, THIS PLUGIN WON"T 100% FOR YOU, AS YOU CHOSE TO USE A SHIT OS

# Setup
```lua
require("wiki").setup("--[[ Path to where your notes will be ]]")
```

# Usage
* In the dir your notes are stored in use the `.md` file format
* To link to another note use the syntax `[[note1]]`
    * It doesn't matter how many sub dirs deep the note is you can still link to it
* If you have a two notes with the same name when jumping too notes the system may get a bit confued as to which note you want

```lua
-- Jump to the linked file the cursor is on
vim.keymap.set("n", "<leader>l", function()
  require("wiki.notes").find_link_file()
end)

-- Find all the references to the current file
vim.keymap.set("n", "<leader>r", function()
  require("wiki.notes").find_links()
end)

-- Search all note in the notes dir
vim.keymap.set("n", "<leader>sn", function()
  require("wiki.notes").search_notes()
end)

-- Search a sub dir in the notes dir (you can add another / to go more dirs deep)
vim.keymap.set("n", "<leader>sc", function()
  require("wiki.notes").search_notes("school")
end)
```

## Script to compile your notes to markdown, pdf, or html
When you open the plugin for the first time there is a bash script aded to
your `~/.local/bin` which allows you to add convert notes. This script will
only work for non windows users.

This script also requires you have pandoc.

### Install pandoc
#### Arch
`sudo pacman -S pandoc`
#### Ubuntu
`sudo apt install pandoc`

### Use the script
```bash
# PDF
convertNote --pdf pathToYourNote

# HTML
convertNote --html pathToYourNote

# Docx
convertNote --docx pathToYourNote
```

The script will output the new file in the same folder as your current note.
