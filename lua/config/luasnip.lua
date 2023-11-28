local ls = require('luasnip')
local extras = require('luasnip.extras')
local fmt = require('luasnip.extras.fmt').fmt

vim.keymap.set({ "i", "s" }, "<C-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-j>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-n>", function()
  if ls.choise_active() then
    ls.change_choise(1)
  end
end, { silent = true })

ls.add_snippets('lua', {
  ls.snippet('hello', {
    ls.text_node('print("Hello '),
    ls.insert_node(1),
    ls.text_node(' world")')
  }),
  ls.snippet('if', fmt(
    [[
    if {} then
      {}
    end
    ]], {
      ls.insert_node(1),
      ls.insert_node(2)
    }
  ))
})

