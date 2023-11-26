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
          {
            function()
              return os.date("%a %H:%M")
            end
          },
          {
            -- function ()
            --   local status = require('lsp-status').status()
            --   vim.notify(status == )
            --   return status
            -- end
            function()
              local clients = vim.lsp.get_active_clients()
              if next(clients) ~= nil then
                local lsp_client_names = {}
                for _, client in ipairs(clients) do
                  table.insert(lsp_client_names, client.name)
                end
                return "LSP: " .. table.concat(lsp_client_names, ", ")
              else
                return "No LSP Connected"
              end
            end,
          },
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
