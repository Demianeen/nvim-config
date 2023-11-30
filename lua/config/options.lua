vim.opt.clipboard = 'unnamedplus' -- Vim starts to use system clipboard

-- tabs
vim.opt.tabstop = 2 -- Number of spaces that a <Tab> in the file counts for
vim.opt.shiftwidth = 2 -- Number of spaces to use for each step of (auto)indent
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.smartindent = true -- Tries to guess and adds intend when start a new line
vim.opt.autoindent = true -- Remembers indent from previous lines

vim.opt.undofile = true -- Sets persistent undo

vim.opt.hlsearch = false -- no highlight during search

-- line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.termguicolors = true -- Increases color palette in vim from 16B to 24

vim.opt.scrolloff = 8 -- Always would be at least n characters in the bottom/ at the top of screen unless the end of the file
vim.opt.signcolumn = 'yes' -- Always show columns for sign at the left part of the window
