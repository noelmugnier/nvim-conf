return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			setup = {
				show_help = true,
				plugins = { spelling = true },
				key_labels = { ["<leader>"] = "SPC" },
				triggers = "auto",
				window = {
					border = "single", -- none, single, double, shadow
					position = "bottom", -- bottom, top
					margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
					padding = { 1, 1, 1, 1 }, -- extra window padding [top, right, bottom, left]
					winblend = 0,
				},
				layout = {
					height = { min = 4, max = 25 }, -- min and max height of the columns
					width = { min = 20, max = 50 }, -- min and max width of the columns
					spacing = 3, -- spacing between columns
					align = "left", -- align columns left, center or right
				},
			},
			defaults = {
				mode = { "n", "v" },
				["<leader>o"] = {
					name = "+Options",
				},
				["<leader>l"] = {
					name = "+Language",
				},
				["<leader>w"] = {
					name = "+Windows",
				},
				["<leader>n"] = { "<ESC>:enew<cr>", "New file" },
				["<leader>q"] = { "<ESC><cmd>qa<cr>", "Quit" },
				["<leader>Q"] = { "<ESC><cmd>qa!<cr>", "Quit without saving" },
				["<leader>S"] = { "<ESC><cmd>wa<cr>", "Save all buffers" },
				["<leader>s"] = {
					function()
						local ok, res = pcall(vim.cmd, "write")
						if ok then
							return
						elseif res:match("E32") then
							ok, res = pcall(vim.fn.input, "File name: ")
							if ok and res and res ~= "" then
								vim.cmd("write " .. res)
							end
						else
							vim.api.nvim_err_writeln(res)
						end
					end,
					"Save buffer",
				},
				["<leader>x"] = { "<ESC>:bd<cr>", "Close buffer" },
				["<leader>wV"] = { "<ESC>:vsp %<cr>", "Vertical split" },
				["<leader>wv"] = { "<ESC>:vnew<cr>", "New Vertical split" },
				["<leader>wS"] = { "<ESC>:sp %<cr>", "Horizontal split" },
				["<leader>ws"] = { "<ESC>:new<cr>", "New Horizontal split" },
				["<leader>wf"] = { "<ESC><C-w>o<CR>", "Focus editor" },
				["<leader>wx"] = { "<ESC><C-w>x<CR>", "Swap editor" },
				["<leader>w="] = { "<ESC><C-w>=<CR>", "Space evenly" },
			},
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts.setup)
			wk.register(opts.defaults)
		end,
	},
}
