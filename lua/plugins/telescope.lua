return {
  'nvim-telescope/telescope.nvim', 
  keys = {
    {"<leader>fa", "<cmd>Telescope find_files<cr>", desc = 'Find files'},
    {"<leader>ff", "<cmd>Telescope git_files<cr>", desc = 'Find files that are not in .gitigonre'},
    {"<leader>fg", "<cmd>Telescope live_grep<cr>", desc = 'Search inside files with grep'},
    {"<leader>fb", "<cmd>Telescope buffers<cr>"},
    {"<leader>fh", "<cmd>Telescope help_tags<cr>"}
  },
  dependencies = { 'nvim-lua/plenary.nvim' }
}
