--[[

What is Kickstart?

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.

--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- not sure but we need it for the tree to work
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- columnn marker
vim.o.colorcolumn = '92'

-- =============================================================================
-- [[ Setting options ]]
-- =============================================================================

require 'options'

-- =============================================================================
-- [[ Basic Keymaps ]]
-- =============================================================================

require 'keymaps'

-- =============================================================================
-- [[ Install `lazy.nvim` plugin manager ]]
-- =============================================================================

require 'lazy-bootstrap'

-- =============================================================================
-- [[ Configure and install plugins ]]
-- =============================================================================

require 'lazy-plugins'

-- -----------------------------------------------------------------------------
-- nvim-tree
-- -----------------------------------------------------------------------------

-- setup with some options
require('nvim-tree').setup {
  sort = {
    sorter = 'case_sensitive',
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
}

-- -----------------------------------------------------------------------------
-- neogit
-- -----------------------------------------------------------------------------

require 'custom.plugins.neogit'

-- -----------------------------------------------------------------------------
-- julia
-- -----------------------------------------------------------------------------

require 'custom.plugins.julia-vim'

-- Run Julia LSP
require'lspconfig'.julials.setup{
    on_new_config = function(new_config, _)
        local julia = vim.fn.expand("~/.julia/environments/nvim-lspconfig/bin/julia")
        if require'lspconfig'.util.path.is_file(julia) then
        -- vim.notify("Hello!")
            new_config.cmd[1] = julia
        end
    end
}

-- -----------------------------------------------------------------------------
-- slime
-- -----------------------------------------------------------------------------

require('custom.plugins.vim-slime')

vim.g.slime_target = 'tmux'
-- vim.g.slime_default_config = {"socket_name" = "default", "target_pane" = "{last}"}
vim.g.slime_default_config = {
  -- Lua doesn't have a string split function!
  socket_name = vim.api.nvim_eval('get(split($TMUX, ","), 0)'),
  target_pane = '{top-right}',
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
