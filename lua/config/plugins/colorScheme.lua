return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  config = function()
    require('catppuccin').setup({
      flavour = 'mocha',
      integrations = {
        cmp = true,
        -- gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = true,
        harpoon = true,
        markdown = true,
        neotest = true,
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
      },
    })
    vim.cmd.colorscheme('catppuccin')
  end,
}
