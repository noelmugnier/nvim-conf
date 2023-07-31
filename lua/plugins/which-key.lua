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
				["<leader>q"] = { "<cmd>qa<cr>", "Quit" },
				["<leader>Q"] = { "<cmd>qa!<cr>", "Quit without saving" },
				["<leader>w"] = {
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
				["<leader>x"] = { "<cmd>q<cr>", "Close buffer" },
			},
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts.setup)
			wk.register(opts.defaults)
		end,
	},
}
