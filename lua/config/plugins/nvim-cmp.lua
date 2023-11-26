return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-buffer', -- recommends text from the current buffer
    'hrsh7th/cmp-path', -- recommends file system paths
    'L3MON4D3/LuaSnip', -- snippet engine
    'saadparwaiz1/cmp', -- autocomplete snippets
    'rafamadriz/friendly-snippets' -- set of predefined snippets
  },
  config = function()
    -- -- Here is where you configure the autocompletion settings.
    -- local lsp_zero = require('lsp-zero')
    -- lsp_zero.extend_cmp()
    --
    -- -- And you can configure cmp even more, if you want to.
    -- local cmp = require('cmp')
    -- local cmp_action = lsp_zero.cmp_action()
    --
    -- cmp.setup({
    --   formatting = lsp_zero.cmp_format(),
    --   mapping = cmp.mapping.preset.insert({
    --     ['<C-Space>'] = cmp.mapping.complete(),
    --     ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    --     ['<C-d>'] = cmp.mapping.scroll_docs(4),
    --     ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    --     ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    --     ['<CR>'] = cmp.mapping.confirm({ select = true }),
    --   })
    -- })

    local cmp = require('cmp')
    local luasnip = require('luasnip')

    -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      completion = {
        completeopt = 'menu,menuone,preview,noselect'
      },
      snippet = {
        expand = function (args)
          luasnip.lsp_expand(args.body)
        end
      }
    })
  end
}
