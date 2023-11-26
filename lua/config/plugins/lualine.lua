return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'archibate/lualine-time'
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
          {'data', function() print(os.date("%H:%M")) end },
          -- {
          --   function ()
          --     local status = require('lsp-status').status()
          --     vim.notify(status == )
          --     return status
          --   end
          -- },
          "filetype",
        },
        lualine_y = {
          'searchcount',
          'progress'
        }
      },
      extensions = {
        'quickfix',
        'mason',
        'lazy'
      }
    })
  end
}
