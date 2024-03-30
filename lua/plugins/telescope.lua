return {
	"nvim-telescope/telescope.nvim",
	config = function()
		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "[S]earch [F]iles" })
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[S]earch [F]iles" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[S]earch [H]elp" })
		vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
		vim.keymap.set("n", "<leader>fF", builtin.live_grep, { desc = "[S]earch by [G]rep" })
		vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
		vim.keymap.set("n", "<leader>fjl", builtin.jumplist, { desc = "[J]ump [L]ist" })
		vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[K]ey[M]aps" })
		vim.keymap.set("n", "<leader>frg", builtin.registers, { desc = "[R]egisters" })
		vim.keymap.set("n", "<leader>ft", builtin.help_tags, { desc = "[H]elp [T]ags" })

		require("telescope").setup({
			defaults = require("telescope.themes").get_dropdown({
				file_sorter = require("telescope.sorters").get_fzy_sorter,
				file_previewer = require("telescope.previewers").vim_buffer_cat.new,
				grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
				qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
				mappings = {
					i = {
						["<C-x>"] = false,
					},
				},
			}),
			extensions = {
				fzy_native = {
					override_generic_sorter = false,
					override_file_sorter = true,
				},
				["ui-select"] = {
					specific_opts = {
						codeactions = false,
					},
				},
			},
		})

		require("telescope").load_extension("fzy_native")
		require("telescope").load_extension("live_grep_args")
		require("telescope").load_extension("ui-select")
	end,
	dependencies = {
		"nvim-telescope/telescope-fzy-native.nvim",
		"nvim-telescope/telescope-live-grep-args.nvim",

		-- Allows using telescope for things like code action (handy for searching)
		"nvim-telescope/telescope-ui-select.nvim",
	},
}
