local Path = require("plenary.path")
local config = require "wiki.config.config"

local data_path = vim.fn.stdpath("data")
local user_config = string.format("%s/wiki.json", data_path)

local wiki = {}

local function read_config(local_config)
  return vim.fn.json_decode(Path:new(local_config):read())
end

function wiki.setup(conf)
  if not conf then
    conf = {}
  end

  -- Check if the config exists at ~/.local/share/nvim/wiki.json
  -- If config does not exist create a config with just two emtpey {}, and propmt user to make a config
  local ok, u_config = pcall(read_config, user_config)

  if not ok then
    -- Set up the user config
    u_config = config.get_defualt_config()

    -- Create the config path at ~/.local/share/nvim/wiki.json
  end

  print(vim.inspect(u_config))
  -- config.notes_dirs()
end

return wiki
