return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-tree/nvim-web-devicons'
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      extensions = {
        fzf = {
          fuzzy = true,                   -- false will only do exact matching
          override_file_sorter = true,    -- override the file sorter
          override_generic_sorter = true, -- override the generic sorter
          case_mode = "smart_case",       -- or "ignore_case" or "respect_case". The default case_mode is "smart_case"
        }
      },
      defaults = {
        path_display = { "truncate " },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next,     -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
    })

    telescope.load_extension("fzf")

    -- keymaps
    vim.keymap.set("n", "<leader>fa", "<cmd>Telescope find_files<cr>", { desc = "Find all files" })
    vim.keymap.set("n", "<leader>ff", "<cmd>Telescope git_files<cr>", { desc = 'Find files that are not in .gitigonre' })
    vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Find recent files" })
    vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Find text inside files" })
    vim.keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = 'Find files from already open ones' })
    vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = 'Find text in help' })
  end
}
