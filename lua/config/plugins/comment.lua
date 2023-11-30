return {
  'numToStr/Comment.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function ()
    local comment = require('comment')
    comment.setup()

    vim.api.nvim_set_keymap('i', '<C-/>', '<Esc>gcc', { noremap = true, silent = true })
  end
}
