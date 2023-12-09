-- LSP Support
return {
  -- LSP Configuration
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  dependencies = {
    -- LSP Manager Plugins
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },

    -- Useful status updates for LSP
    { 'j-hui/fidget.nvim',                opts = {} },

    -- Additional lua configuration, makes nvim stuff amazing!
    { 'folke/neodev.nvim' },
  },
}
