return {
	{
		"mrjones2014/legendary.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>ok", "<cmd>Legendary<cr>", desc = "Keybindings" },
		},
		dependencies = {
			{ "nvim-telescope/telescope.nvim" },
		},
		opts = {
			which_key = { auto_register = true, use_groups = true },
			lazy_nvim = { auto_register = true },
			extensions = {
				nvim_tree = true,
			},
		},
	},
}
