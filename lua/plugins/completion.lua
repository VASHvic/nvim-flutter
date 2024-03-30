return {
		"hrsh7th/nvim-cmp",
	config = function()
    local cmp = require("cmp")
    local cmp_mappings = cmp.mapping.preset.insert({
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ["<C-y>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = false }),
    })

		-- disable completion with tab (Copilot)
		cmp_mappings["<Tab>"] = vim.NIL
		cmp_mappings["<S-Tab>"] = vim.NIL

		---@diagnostic disable-next-line: missing-fields
		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			sources = {
				{ name = "nvim_lsp" },
				{ name = "path" },
				{ name = "luasnip" },
				{ name = "buffer" },
			},
			mapping = cmp_mappings,
		})

		-- Snippets will load from LSP but this makes sure to
		-- load local and plugin snippets ASAP
		require("luasnip.loaders.from_vscode").lazy_load()
	end,
	dependencies = {
		-- Autocompletion
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lua",

		-- Snippets engine
		{
			"L3MON4D3/LuaSnip",
			dependencies = {

				"saadparwaiz1/cmp_luasnip",
				"rafamadriz/friendly-snippets",
			},
		},
	},
}
