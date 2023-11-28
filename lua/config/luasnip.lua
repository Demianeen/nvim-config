local ls = require('luasnip')

vim.keymap.set({ "i", "s" }, "<A-k>", function()
if ls.expand_or_jumpable() then
ls. expand_or_jump ()
end
end, { silent = true })

vim. keymap.set(‹ "i", "s" 3, "<A-j>", function()
if ls. jumpable(-1) then
ls. jump(-1)
end
end, { silent = true 3)

ls.add_snippets('lua', {
  ls.snippet('hello', {
    ls.text_node('print("Hello '),
    ls.insert_node(1),
    ls.text_node(' world")')
  })
})

