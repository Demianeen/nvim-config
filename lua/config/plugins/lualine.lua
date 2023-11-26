return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
  config = function()
    local lualine = require('lualine')
    local lazy_status = require('lazy.status')

    lualine.setup({
      sections = {
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          "os.date('%a')",
          'data',
          "require'lsp-status'.status()",
          "filetype",
        },
        lualine_y = {
          'searchcount',
          'progress'
        }
      }
    })
  end
}
