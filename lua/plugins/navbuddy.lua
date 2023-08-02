return {
	{
		"SmiteshP/nvim-navbuddy",
		dependencies = {
			"SmiteshP/nvim-navic",
			"MunifTanjim/nui.nvim",
		},
		config = {
			window = {
				border = "rounded",
			},
			lsp = { auto_attach = true },
		},
	},
}
