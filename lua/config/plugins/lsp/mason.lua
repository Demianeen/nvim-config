return {
  {
    'williamboman/mason.nvim',
    lazy = false,
    config = function()
      local mason = require('mason')
      local mason_lspconfig = require('mason-lspconfig')

      mason.setup()

      mason_lspconfig.setup({
        ensure_installed = {
          'cssls',  -- css-lsp
          'eslint', -- eslint-lsp
          'html',   -- html-lsp
          'lua_ls', -- lua-language-server
          'stylelint_lsp', -- stylelint-lsp
          'tsserver',      -- typescript-language-server
          'vimls',         -- vim-language-server
          'vtsls',
          'emmet_ls'
        },
        automatic_installation = true -- automaticly installs lsps when you open file without them
      })
    end,
    dependencies = {
      'williamboman/mason-lspconfig.nvim'
    }
  },
}
