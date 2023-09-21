if vim.g.vscode then
	-- VSCode extensions
else
	require("config.options")
	require("config.lazy")

	if vim.fn.argc(-1) == 0 then
		vim.api.nvim_create_autocmd("User", {
			group = vim.api.nvim_create_augroup("NeovimPDE", { clear = true }),
			pattern = "VeryLazy",
			callback = function()
				require("config.autocmds")
				require("config.keymaps")
			end,
		})
	else
		require("config.autocmds")
		require("config.keymaps")
	end
	vim.g.copilot_no_tab_map = true
	vim.g.copilot_assume_mapped = true
	vim.api.nvim_set_keymap("i", "<C-l>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
	vim.api.nvim_set_keymap("i", "<C-M-k>", "copilot#Previous()", { silent = true, expr = true })
	vim.api.nvim_set_keymap("i", "<C-M-j>", "copilot#Next()", { silent = true, expr = true })
end
