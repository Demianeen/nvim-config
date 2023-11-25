return {
  'ThePrimeagen/harpoon',
  keys = {
    "<leader>ma",
    "<leader>me",
    "<leader>m1",
    "<leader>m2",
    "<leader>m3",
    "<leader>m4",
  },
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function ()
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")

    vim.keymap.set("n", "<leader>ma", mark.add_file)
    vim.keymap.set("n", "<leader>me", ui.toggle_quick_menu)

    vim.keymap.set("n", "<leader>m1", function() ui.nav_file(1) end)
    vim.keymap.set("n", "<leader>m2", function() ui.nav_file(2) end)
    vim.keymap.set("n", "<leader>m3", function() ui.nav_file(3) end)
    vim.keymap.set("n", "<leader>m4", function() ui.nav_file(4) end)
  end
}
