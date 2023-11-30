return {
  'numToStr/Comment.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function ()
    local comment = require('Comment')
    comment.setup()

    vim.api.nvim_set_keymap('i', '<C-/>', '<Esc>gcci', { noremap = true, silent = true })
  end
}
