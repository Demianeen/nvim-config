-- nvim tree auto rename on didRename
local path_sep = package.config:sub(1, 1)

local function trim_sep(path)
  return path:gsub(path_sep .. '$', '')
end

local function uri_from_path(path)
  return vim.uri_from_fname(trim_sep(path))
end

local function is_sub_path(path, folder)
  path = trim_sep(path)
  folder = trim_sep(path)
  if path == folder then
    return true
  else
    return path:sub(1, #folder + 1) == folder .. path_sep
  end
end

local function check_folders_contains(folders, path)
  for _, folder in pairs(folders) do
    if is_sub_path(path, folder) then return true end
  end
  return false
end

local function match_file_operation_filter(filter, name, type)
  if filter.scheme and filter.scheme ~= 'file' then
    -- we do not support uri scheme other than file
    return false
  end
  local pattern = filter.pattern
  local matches = pattern.matches

  if type ~= matches then return false end

  local regex_str = vim.fn.glob2regpat(pattern.glob)
  if vim.tbl_get(pattern, 'options', 'ignoreCase') then
    regex_str = '\\c' .. regex_str
  end
  return vim.regex(regex_str):match_str(name) ~= nil
end

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

    -- nvim tree auto rename on didRename
    local api = require('nvim-tree.api')
    api.events.subscribe(api.events.Event.NodeRename, function(data)
      local stat = vim.loop.fs_stat(data.new_name)
      if not stat then return end
      local type = ({ file = 'file', directory = 'folder' })[stat.type]
      local clients = vim.lsp.get_active_clients({})
      for _, client in ipairs(clients) do
        if check_folders_contains(client.workspace_folders, data.old_name) then
          local filters = vim.tbl_get(
            client.server_capabilities,
            'workspace',
            'fileOperations',
            'didRename',
            'filters'
          ) or {}
          for _, filter in pairs(filters) do
            if
              match_file_operation_filter(filter, data.old_name, type)
              and match_file_operation_filter(filter, data.new_name, type)
            then
              client.notify('workspace/didRenameFiles', {
                files = {
                  {
                    oldUri = uri_from_path(data.old_name),
                    newUri = uri_from_path(data.new_name),
                  },
                },
              })
            end
          end
        end
      end
    end)
  end,
}
