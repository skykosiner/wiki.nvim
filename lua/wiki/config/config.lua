local Path = require("plenary.path")

local data_path = vim.fn.stdpath("data")
local user_config = string.format("%s/wiki.json", data_path)

local config = {}

local function merge_table_impl(t1, t2)
  for k, v in pairs(t2) do
    if type(v) == "table" then
      if type(t1[k]) == "table" then
        merge_table_impl(t1[k], v)
      else
        t1[k] = v
      end
    else
      t1[k] = v
    end
  end
end

local function MergeTables(...)
  local out = {}
  for i = 1, select("#", ...) do
    merge_table_impl(out, select(i, ...))
  end

  return out
end

--[[
{
  "mainNoteDir": "/path/to/notes",
  "notes": {
    "/path/to/note": {
      "links": {
        "/path/to/links"
      },
    },
  },
}
--]]

function config.notes_dirs(opts)
  return opts
end

function config.get_defualt_config()
  local conf = MergeTables({
    ["mainNoteDir"] = os.getenv("HOME"),
    ["notes"] = {
      nil
    },
  })

  return conf
end

return config
