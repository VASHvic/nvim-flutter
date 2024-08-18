return {
	"mhartington/formatter.nvim",
	config = function()
		local settings = {
			lua = {
				require("formatter.filetypes.lua").stylua,
			},
			typescriptreact = {
				require("formatter.filetypes.typescript").prettier,
			},
			typescript = {
				require("formatter.filetypes.typescript").prettier,
			},
			css = {
				require("formatter.filetypes.css").prettier,
			},
			-- dart = {
			-- 	require("formatter.filetypes.dart").dartformat,
			-- },
			["*"] = {
				vim.notify("No formatter defined", vim.log.levels.WARN),
				-- require("formatter.filetypes.any").remove_trailing_whitespace,
			},
		}

		require("formatter").setup({
			logging = true,
			log_level = vim.log.levels.WARN,
			filetype = settings,
		})

		-- BufWritePre es ralla al ser asyncrono
		vim.api.nvim_create_autocmd("BufWritePost", {
			callback = function()
				vim.cmd([[Format]])
			end,
		})

		vim.keymap.set("n", "<leader>gf", function()
			if settings[vim.bo.filetype] ~= nil then
				vim.cmd([[Format]])
			else
				vim.lsp.buf.format({
					filter = function(client)
						local clients = vim.lsp.get_active_clients()
						local formattingDartWithDcmls = false

						-- Check if dcmls is attached
						for _, c in ipairs(clients) do
							if c.name == "dcmls" then
								formattingDartWithDcmls = true
								break -- No need to continue checking clients if dcmls is found
							end
						end

						-- Return false for dart if dcmls is attached
						if formattingDartWithDcmls and client.name == "dartls" then
							return false
						end

						return true
					end,
				})
			end
		end)

		-- Format after save ( ho tinc comentat per que
		-- no funciona en el ubuntu de wsl hasta que actualitze glibc

		-- vim.api.nvim_exec(
		-- 	[[
		-- 	augroup FormatAutogroup
		-- 		autocmd!
		-- 		autocmd BufWritePost * FormatWrite
		-- 	augroup END
		-- ]],
		-- 	false
		-- )
	end,
}
