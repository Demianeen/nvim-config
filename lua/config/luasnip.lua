local ls = require('luasnip')

ls.add_snippets('lua', {
  ls.snippet('hello', {
    ls.text_node('print("Hello '),
    ls.insert_node(1),
    ls.text_node(' world)')
  })
})

