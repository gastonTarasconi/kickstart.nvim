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
    { 'j-hui/fidget.nvim', opts = {} },

    -- Additional lua configuration, makes nvim stuff amazing!
    { 'folke/neodev.nvim' },
  },
  config = function()
    -- mason-lspconfig requires that these setup functions are called in this order
    -- before setting up the servers.
    require('mason').setup()
    require('mason-lspconfig').setup({
      -- Update this list to the language servers you need installed
      ensure_installed = {
        -- "bashls", # requires npm to be installed
        -- "cssls", # requires npm to be installed
        -- "html", # requires npm to be installed
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
    local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

    --  This function gets run when an LSP connects to a particular buffer.
    local lsp_attach = function(_, bufnr)
      -- Create your keybindings here...
      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
      end, { desc = 'Format current buffer with LSP' })
    end

    -- Call setup on each LSP server
    require('mason-lspconfig').setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({
          on_attach = lsp_attach,
          capabilities = lsp_capabilities,
        })
      end
    })

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
  end
}
