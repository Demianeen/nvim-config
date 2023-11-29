return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		-- sub-list runs only the first available formatter
		local prettierFormatter = {
			"prettierd",
			"prettier",
		}

		local format_options = {
			-- falback to lsp if formatters are not avaliable
			lsp_fallback = true,
			timeout_ms = 500,
		}

		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				javascript = {
					prettierFormatter,
				},
				javascriptreact = {
					prettierFormatter,
				},

				typescript = {
					prettierFormatter,
				},
				typescriptreact = {
					prettierFormatter,
				},

				svelte = {
					prettierFormatter,
				},
				css = {
					prettierFormatter,
				},
				html = {
					prettierFormatter,
				},
				josn = {
					prettierFormatter,
				},
				yaml = {
					prettierFormatter,
				},
				markdown = {
					prettierFormatter,
				},
			},
			format_on_save = format_options,
			notify_on_error = true,
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format(format_options)
		end, {
			desc = "Format file or range(in visual mode)",
		})
	end,
}
