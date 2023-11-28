local ls = require('luasnip')
local extras = require('luasnip.extras')
local fmt = require('luasnip.extras.fmt').fmt

local get_reg = require("config.lib.get_reg")

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
  )),
  ls.snippet('co', {
    ls.dynamic_node(function()
      local register_data = get_reg('*') .. ""
      if string.match(register_data, '[%d-]+,%s*[%d-]+') then
        return ls.snippet_node(nil, {
          ls.text_node('position([' .. register_data .. '])')
        })
      end
    end)
  })
})

ls.add_snippets('typescriptreact', {
  ls.snippet('co', {
    ls.dynamic_node(function()
      local register_data = get_reg('*') .. ""
      if string.match(register_data, '[%d-]+,%s*[%d-]+') then
        return ls.snippet_node(nil, {
          ls.text_node('position([' .. register_data .. '])')
        })
      end
    end)
  })
})


