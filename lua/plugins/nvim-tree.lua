-- not working. Issue similar to https://github.com/nvim-tree/nvim-tree.lua/issues/767
return {
  'nvim-tree/nvim-tree.lua',
  dependency = { 'nvim-web-devicons' },
  lazy = true,
  keys = {
    { "<leader>tt", "<cmd>NvimTreeToggle<CR>"},
  },
  config = function()
    local nvimTree = require("nvim-tree")
    -- disable netrw at the very start of your init.lua
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- set termguicolors to enable highlight groups
    vim.opt.termguicolors = true

    nvimTree.setup()
  end
}
