vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('lazysetup')

require('plugins.configs.telescope')
require('plugins.configs.treesitter')
require('plugins.configs.lsp')
require('plugins.configs.whichkey')
require('plugins.configs.nvimcmp')
require('plugins.configs.harpoon')

require('options')
require('keymaps')
require('augroupscommands')
