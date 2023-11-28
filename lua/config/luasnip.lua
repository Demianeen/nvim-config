local ls = require('luasnip')

ls.add_snippet('lua', {
  ls.snippet('hello', {
    ls.text_node('print("Hello world")')
  })
})
