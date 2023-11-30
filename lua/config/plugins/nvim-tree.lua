return {
  'nvim-tree/nvim-tree.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local nvimtree = require('nvim-tree')

    -- disable netrw at the very start of your init.lua
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- change color for arrows in tree to light blue
    vim.cmd([[ highlight NvimTreeFolderArrowClosed guifg=#3FC5FF ]])
    vim.cmd([[ highlight NvimTreeFolderArrowOpen guifg=#3FC5FF ]])

    local function on_attach(bufnr)
      local api = require('nvim-tree.api')

      local function opts(desc)
        return {
          desc = 'nvim-tree: ' .. desc,
          buffer = bufnr,
          noremap = true,
          silent = true,
          nowait = true,
        }
      end

      -- default mappings
      api.config.mappings.default_on_attach(bufnr)

      -- custom mappings
      vim.keymap.set(
        'n',
        'p',
        api.tree.change_root_to_parent,
        opts('Up to parent')
      )
      vim.keymap.set(
        'n',
        'P',
        api.tree.change_root_to_parent,
        opts('Open parent folder in explorer')
      )
      vim.keymap.set('n', 'l', 'o', opts('Open file'))
      vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
    end

    -- configure nvim-tree
    nvimtree.setup({
      view = {
        adaptive_size = true,
        -- relativenumber = true,
      },
      -- change folder arrow icons
      renderer = {
        highlight_git = true,
        indent_markers = {
          enable = false,
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = '', -- arrow when folder is closed
              arrow_open = '', -- arrow when folder is open
            },
          },
        },
      },
      -- disable window_picker for
      -- explorer to work well with
      -- window splits
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
          quit_on_open = true,
        },
      },
      filters = {
        custom = { '.DS_Store' },
      },
      git = {
        ignore = true,
      },
      -- keep cursor on first file letter while moving the tree
      hijack_cursor = true,
      disable_netrw = true,
      -- open nvim-tree instead off unnamed buffer
      hijack_unnamed_buffer_when_opening = true,
      -- still haven't figure out what it is. But nvim-tree do recommend it to set to true when using dressing.nvim
      select_prompts = true,
      on_attach = on_attach,
    })

    vim.keymap.set(
      'n',
      '<leader>ee',
      '<cmd>NvimTreeToggle<CR>',
      { desc = 'Toggle file explorer' }
    ) -- toggle file explorer
    vim.keymap.set(
      'n',
      '<leader>ef',
      '<cmd>NvimTreeFindFileToggle<CR>',
      { desc = 'Toggle file explorer on current file' }
    ) -- toggle file explorer on current file
    vim.keymap.set(
      'n',
      '<leader>er',
      '<cmd>NvimTreeRefresh<CR>',
      { desc = 'Refresh file explorer' }
    ) -- refresh file explorer
  end,
}
