return {
	-- Neovim development
	"folke/neodev.nvim",

	-- Language support, mainly for indentation because it's more stable than treesitter in Dart
	"dart-lang/dart-vim-plugin",

	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup()
		end,
	},

	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
			vim.keymap.set("n", "<leader>gh", ":diffget //2<CR>")
			vim.keymap.set("n", "<leader>gl", ":diffget //3<CR>")
		end,
	},
	{
		"ruifm/gitlinker.nvim",
		config = function()
			-- default keybind is <leader>gy
			require("gitlinker").setup()
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
 {
    'navarasu/onedark.nvim',
    priority = 1000,
    lazy = false,
    config = function()
      require('onedark').setup {
        -- Set a style preset. 'dark' is default.
        style = 'dark', -- dark, darker, cool, deep, warm, warmer, light
      }
      require('onedark').load()
    end,
  },
}
