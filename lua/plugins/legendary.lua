return {
	{
		"mrjones2014/legendary.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>ok", "<cmd>Legendary<cr>", desc = "Keybindings" },
		},
		opts = {
			which_key = { auto_register = true },
			lazy_nvim = { auto_register = true },
		},
	},
}
