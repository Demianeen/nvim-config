local ls = require('luasnip')

ls.add_snippets('lua', {
  ls.snippet('hello', {
    ls.text_node('print("Hello world")')
  })
})
