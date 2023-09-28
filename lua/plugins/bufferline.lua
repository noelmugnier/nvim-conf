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
				indicator = {
					icon = "▎", -- this should be omitted if indicator style is not 'icon'
					style = "icon",
				},
				show_tab_indicators = true,
				show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
				persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
				separator_style = "thick",
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(count, level, diagnostics_dict, context)
					if level:match("error") and count > 0 then
						return " "
					end

					return ""
				end,
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
