return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
	 { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	config = function()
		local builtin = require("telescope.builtin")

		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { desc = "Search: " .. desc })
		end

		map("<leader><space>", builtin.find_files, "Search Files")
		map("<leader>sg", builtin.live_grep, "[S]earch by [G]rep")
		map("<leader>sp", builtin.git_files, "[S]earch Git [P]roject  Files")
		map("<leader>sb", builtin.buffers, "[S]earch for existing [B]uffers")

		map("<leader>sw", builtin.grep_string, "[S]earch current [W]ord")
		map("<leader>sd", builtin.diagnostics, "[S]earch [D]iagnostics")
		map("<leader>sr", builtin.resume, "[S]earch [R]esume")
		map("<leader>sh", builtin.help_tags, "[S]earch [H]elp")
		map("<leader>sk", builtin.keymaps, "[S]earch [K]eymaps")

		map("<leader>sn", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, "[S]earch [N]eovim files")
	end,
}
