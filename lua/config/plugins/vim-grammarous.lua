vim.g['grammarous#jar_url'] =
  'https://www.languagetool.org/download/LanguageTool-5.9.zip'

return {
  'rhysd/vim-grammarous',
  event = { 'BufReadPre', 'BufNewFile' },
}
