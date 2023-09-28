return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			defaults = {
				["<leader>b"] = { name = "+Buffers" },
			},
		},
	},
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = {
			options = {
				diagnostics = "nvim_lsp",
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						text_align = "left",
						separator = true,
					},
				},
			},
		},
		keys = {
			{ "]t", ":BufferLineCycleNext<CR>", desc = "Go to next buffer" },
			{ "]T", ":BufferLineMoveNext<CR>", desc = "Move buffer right" },
			{ "[t", ":BufferLineCyclePrev<CR>", desc = "Go to previous buffer" },
			{ "[T", ":BufferLineMovePrev<CR>", desc = "Move buffer left" },
			{ "gB", ":BufferLinePick<CR>", desc = "Go to buffer" },
			{ "<leader>bx", ":BufferLineCloseOthers<CR>", desc = "Close other buffers" },
			{ "<leader>bp", ":BufferLineTogglePin<CR>", desc = "Pin/Unpin current buffer" },
		},
	},
}
