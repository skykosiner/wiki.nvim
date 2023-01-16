**THIS IS NOT VIMWIKI NOR IS IT AS POWERFUL THIS IS A LITTLE TOOL I WROTE FOR MY SELF WITH ONLY THE FUNCTIONS I NEED**

# Setup
```lua
require("wiki").setup("--[[ Path to where your notes will be ]]")
```

# Usage
* In the dir your notes are stored in use the `.md` file format
* To link to another note use the syntax `[[note1]]`
    * It doesn't matter how many sub dirs deep the note is you can still link to it

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
