-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Install `lazy.nvim` plugin manager ]]
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Initialize lazy with dynamic loading of anything in the plugins directory
require("lazy").setup("plugins", {
  change_detection = {
    enabled = true, -- automatically check for config file changes and reload the ui
    notify = false, -- turn off notifications whenever plugin changes are made
  },
})

-- TODO: try to move to another file
-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require('mason').setup()
require('mason-lspconfig').setup({
  -- Update this list to the language servers you need installed
  ensure_installed = {
    "bashls", -- requires npm to be installed
    "cssls",  -- requires npm to be installed
    "html",   -- requires npm to be installed
    -- "gradle_ls",
    -- "groovyls",
    "lua_ls",
    -- "intelephense", # requires npm to be installed
    -- "jsonls", # requires npm to be installed
    -- "lemminx",
    -- "marksman",
    -- "quick_lint_js",
    "tsserver", -- requires npm to be installed
    -- "yamlls", # requires npm to be installed
  }
})

local lspconfig = require('lspconfig')
-- local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

-- --  This function gets run when an LSP connects to a particular buffer.
-- local lsp_attach = function(_, bufnr)
--   -- Create your keybindings here...
--   -- Create a command `:Format` local to the LSP buffer
--   vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
--     vim.lsp.buf.format()
--   end, { desc = 'Format current buffer with LSP' })
-- end

-- Call setup on each LSP server
-- require('mason-lspconfig').setup_handlers({
--   function(server_name)
--     lspconfig[server_name].setup({
--       on_attach = lsp_attach,
--       capabilities = lsp_capabilities,
--     })
--   end
-- })

-- Lua LSP settings
lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
    },
  },
}


-- These modules are not loaded by lazy
require('core.options')
require('core.keymaps')
require('core.augroupscommands')
