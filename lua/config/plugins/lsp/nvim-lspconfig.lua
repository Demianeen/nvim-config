return {
  'neovim/nvim-lspconfig',
  cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    { 'antosha417/nvim-lsp-file-operations', config = true }
  },
  config = function()
    local lspconfig = require('lspconfig')
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local options = { noremap = true, silent = true }

    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(ev)
        options.buffer = ev.bufnr

        -- keymaps
        options.desc = "Show LSP references"
        vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", options) -- show definition, references

        options.desc = "Go to declaration"
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, options) -- go to declaration

        options.desc = "Show LSP definitions"
        vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", options) -- show lsp definitions

        options.desc = "Show LSP implementations"
        vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", options) -- show lsp implementations

        options.desc = "Show LSP type definitions"
        vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", options) -- show lsp type definitions

        options.desc = "See available code actions"
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, options) -- see available code actions, in visual mode will apply to selection

        options.desc = "Smart rename"
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, options) -- smart rename

        options.desc = "Show buffer diagnostics"
        vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", options) -- show  diagnostics for file

        options.desc = "Show line diagnostics"
        vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, options) -- show diagnostics for line

        options.desc = "Go to previous diagnostic"
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, options) -- jump to previous diagnostic in buffer

        options.desc = "Go to next diagnostic"
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, options) -- jump to next diagnostic in buffer

        options.desc = "Show documentation for what is under cursor"
        vim.keymap.set("n", "K", vim.lsp.buf.hover, options) -- show documentation for what is under cursor

        options.desc = "Restart LSP"
        vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", options) -- mapping to restart lsp if necessary
      end
    })

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- languages configurations
    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      settings = { -- custom settings for lua
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            -- make language server aware of runtime files
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })

    lspconfig['html'].setup({
      capabilities = capabilities,
    })

    lspconfig['cssls'].setup({
      capabilities = capabilities,
    })

    lspconfig['emmet_ls'].setup({
      capabilities = capabilities,
      filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'scss', 'sass', 'less', 'svelte' }
    })

    lspconfig['vtsls'].setup({
      capabilities = capabilities,
    })

    lspconfig.eslint.setup({
      on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "EslintFixAll",
        })
      end,
    })
  end
}
