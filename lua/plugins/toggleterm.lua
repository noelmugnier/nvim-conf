return {
	{
		"akinsho/toggleterm.nvim",
		lazy = false,
		opts = {
			-- size can be a number or function which is passed the current terminal
			size = function(term)
				if term.direction == "horizontal" then
					return 20
				elseif term.direction == "vertical" then
					return 50
				end
			end,
			hide_numbers = true, -- hide the number column in toggleterm buffers
			autochdir = true, -- when neovim changes it current directory the terminal will change it's own when next it's opened
			start_in_insert = true,
			-- insert_mappings = true, -- whether or not the open mapping applies in insert mode
			-- terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
			persist_size = true,
			persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
			direction = "float",
			close_on_exit = true, -- close the terminal window when the process exits
			-- Change the default shell. Can be a string or a function returning a string
			shell = vim.o.shell,
			auto_scroll = true, -- automatically scroll to the bottom on terminal output
			-- This field is only relevant if direction is set to 'float'
		},
		config = function(_, opts)
			require("toggleterm").setup(opts)
		end,
		keys = {
			{ "<c-t>", '<cmd>1TermExec cmd="clear" name=console<cr>', mode = { "n" } },
			{ "<a-t>", "<cmd>ToggleSelect<cr>", mode = { "n" } },
			{ "<c-t>", "<cmd>ToggleTerm<cr>", mode = { "t" } },
			{ "<c-g>", '<cmd>5TermExec cmd="lazygit" name=git<cr>', mode = { "n" } },
			{ "<c-m>", '<cmd>6TermExec cmd="htop" name=htop<cr>', mode = { "n" } },
		},
	},
}
