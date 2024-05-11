return {
	"mfussenegger/nvim-lint",
	event = {
		"BufReadPre",
		"BufNewFile",
	},

	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			lua = { "selene" },
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
		}

		local eslintd = lint.linters.eslint_d

		eslintd.args = {
			--            '--no-warn-ignored',
			"--format",
			"json",
			"--stdin",
			"--stdin-filename",
			function()
				return vim.api.nvim_buf_get_name(0)
			end,
		}

		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			group = vim.api.nvim_create_augroup("RestartEslint", { clear = true }),
			pattern = "*eslint*",
			callback = function()
				vim.fn.system("eslint_d restart")
			end,
		})

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = vim.api.nvim_create_augroup("StartLinting", { clear = true }),
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
