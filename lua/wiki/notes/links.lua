local utils = require "wiki.utils"
local links = {}

function links.find_links()
  -- Get's the current filename trims off the .md suffix
  local currentNoteName = string.gsub(vim.fn.expand("%:t"), string.format(".%s", vim.fn.expand("%:e")), "")
  -- Grep each file in the current dir for the string [[note-name]] in order to find all the links
  require("telescope.builtin").grep_string({ search = string.format("[[%s]]", currentNoteName) })
end

function links.find_link_file()
  local file = string.format("%s.md", vim.fn.expand("<cword>"))
  -- Get the path to the where the file of the current word is
  local notePath = vim.fn.systemlist(string.format("find . -path '*%s'", file))

  -- Create the note if it does not exist and then jump to it
  if notePath == nil then
    -- Use the || not the && incase the dir is already made so that it will just ignore the error.
    -- As the && syntax makes sure both don't error, and if the dir already exists mkdir will error
    os.execute(string.format("mkdir %s/misc 2> /dev/null || touch %s/misc/%s", vim.g.notesDir, vim.g.notesDir, file))
    notePath = vim.fn.systemlist(string.format("find . -path '*%s'", file))[1]
  end

  -- If there is more then one file with that name then let the user pick which one to open up
  if utils.tbl_len(notePath) ~= 1 then
    print("more then one????")
    require("telescope.pickers").new({}, {
      prompt_title = "< Pick a link file >",
      finder = require("telescope.finders").new_table({
        results = notePath,
      }),
      sorter = require("telescope.config").values.generic_sorter({}),
      attach_mappings = function(_, map)
        map("i", "<CR>", function(prompt_bufnr)
          local content = require("telescope.actions.state").get_selected_entry(
            prompt_bufnr
          )

          require("telescope.actions").close(prompt_bufnr)
          vim.cmd("e " .. content.value)
        end)
        return true
      end,
    }):find()
  else
    notePath = notePath[1]
    vim.cmd("e " .. notePath)
  end
end

return links
