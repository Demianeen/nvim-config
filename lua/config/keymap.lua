local get_reg = require('config.lib.get_reg')

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true, silent = true })

-- add tabs in visual mode
vim.keymap.set('v', '<Tab>', '>gv', { noremap = true, silent = true })
vim.keymap.set('v', '<S-Tab>', '<gv', { noremap = true, silent = true })

-- open lazy's' window
vim.keymap.set('n', '<C-L>', ':Lazy<CR>', { noremap = true, silent = true })

-- paste/delete and not copy
vim.keymap.set("x", "<leader>p", '"_dP')
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- allows to move selected code up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- concats strings but leaves cursor in place
vim.keymap.set("n", "J", "mzJ`z")

-- half page down/up, but centers page
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- next/previus search result, but centers page and folded code unfolds
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- disable Q
vim.keymap.set("n", "Q", "<nop>")

-- swap between projects in one window
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- format document
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- custom next/previous for quickfix & location lists
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- insert author/repo from gh repo link
vim.keymap.set("n", "<leader>gp", function()
  local clipboard = get_reg('*')

  -- vim.notify(clipboard)
  local author, repo = clipboard:match("https://github%.com/([%w-%.]+)/([%w-%.]+)")
  if author and repo then
    local pasteValue = "'" .. author .. '/' .. repo .. "'"
    vim.api.nvim_put({ pasteValue }, 'c', true, true)
  else
    vim.notify("No GitHub URL found in clipboard")
  end
end)

-- turns off highlight
vim.keymap.set('n', '<Esc><Esc>', ':noh<CR>')

-- Open new line on ctrl enter in insert mode
vim.keymap.set('i', '<C-CR>', '<Esc>o')

-- auto regex search & replace
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("v", "<leader>s", function()
  -- Get the start and end of the visual selection
  local start_pos = vim.fn.getpos("v")
  local end_pos = vim.fn.getpos(".")
  local start_line, start_col = start_pos[2], start_pos[3]
  local end_line, end_col = end_pos[2], end_pos[3]

  -- Adjust end_col to include the last character in the selection
  if end_col > 0 then
    end_col = end_col - 1
  end

  -- Get the text of the visual selection
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  if #lines == 0 then
    vim.notify('No lines selected')
    return
  end

  local selection = table.concat(lines, '\n')
  print(selection)
  if #lines > 1 then
    vim.notify('More than 1 line selected')
    return
  else
    selection = selection:sub(start_col, end_col + 1)
  end

  -- Escape special characters
  selection = selection:gsub("/", "\\/")

  -- Prepare the substitute command
  local command = ":s/" .. selection .. "/" .. selection .. "/gI"
  vim.api.nvim_feedkeys(command, "n", true)
end)


-- makes file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader><leader>", function()
  vim.cmd("w")
  vim.cmd("so")
  print("saved and sourced")
end)
