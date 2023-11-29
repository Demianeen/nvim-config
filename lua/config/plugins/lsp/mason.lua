return {
  {
    'williamboman/mason.nvim',
    lazy = false,
    config = function()
      local mason = require('mason')
      local mason_lspconfig = require('mason-lspconfig')
      local mason_tool_installer = require('mason-tool-installer')

      mason.setup()

      mason_lspconfig.setup({
        ensure_installed = {
          -- lsp
          'cssls', -- css-lsp
          'eslint', -- eslint-lsp
          'html', -- html-lsp
          'lua_ls', -- lua-language-server
          'stylelint_lsp', -- stylelint-lsp
          'tsserver', -- typescript-language-server
          'vimls', -- vim-language-server
          'vtsls',
          'emmet_ls',
        },
        automatic_installation = true, -- automaticly installs lsps when you open file without them
      })

      mason_tool_installer.setup({
        ensure_installed = {
          --debuggers
          'chrome-debug-adapter',
          'js-debug-adapter',
          'node-debug2-adapter',
          -- linters
          'pylint',
          'selene',
          -- formatters
          'stylua',
          'black',
          'isort',
          'prettierd',
          'prettier',
        },
      })
    end,
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
  },
}
