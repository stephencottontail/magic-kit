-- Welcome to your magic kit!
-- This is the first file Neovim will load.
-- We'll ensure we have a plugin manager and Aniseed.
-- This will allow us to load more Fennel based code and download more plugins.

-- Make some modules easier to access.
local execute = vim.api.nvim_command
local fn = vim.fn
local opt = vim.opt
local fmt = string.format

-- Work out where our plugins will be stored.
local pack_path = fn.stdpath("config") .. "/lazy"

function ensure (user, repo)
  -- Ensures a given github.com/USER/REPO exists at `pack_path`
  local install_path = fmt("%s/%s", pack_path, repo)
  if fn.empty(fn.glob(install_path)) > 0 then
    execute(fmt("!git clone https://github.com/%s/%s %s", user, repo, install_path))
  end
  opt.runtimepath:append(install_path)
end

-- lazy.nvim is our plugin manager.
ensure("folke", "lazy.nvim")

-- Aniseed compiles our Fennel code to Lua and loads it automatically.
ensure("Olical", "aniseed")

-- Enable Aniseed's automatic compilation and loading of Fennel source code.
-- Aniseed looks for this when it's loaded then loads the rest of your
-- configuration if it's set.
vim.g["aniseed#env"] = {module = "magic.init"}

-- Now head to fnl/magic/init.fnl to continue your journey.
-- Try pressing gf on the file path to [g]o to the [f]ile.
