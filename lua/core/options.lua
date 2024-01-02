-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Tabs & Indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.bo.softtabstop = 2

-- Enable mouse mode
-- vim.o.mouse = 'a'
vim.o.mouse = ''

-- Sync clipboard between OS and Neovim.
vim.o.clipboard = 'unnamedplus'
-- TODO: check
-- vim.opt.clipboard:append("unnamedplus")

-- Enable break indent
vim.o.breakindent = true

-- Disable wrap
vim.o.wrap = false

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Terminal colors
vim.o.termguicolors = true

-- Netrw
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

vim.opt.colorcolumn = '80'

vim.opt.fileencoding = 'utf-8'

-- Consider - as part of keyword
vim.opt.iskeyword:append("-")
