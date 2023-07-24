return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		cmd = "Telescope",
    -- stylua: ignore
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Git Files" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
            { "<leader>fs", "<cmd>Telescope live_grep_args<cr>", desc = "Search" },

    },
		opts = {
			defaults = {
				mappings = {
					i = {
						["<C-j>"] = function(...)
							require("telescope.actions").move_selection_next(...)
						end,
						["<C-k>"] = function(...)
							require("telescope.actions").move_selection_previous(...)
						end,
						["<C-n>"] = function(...)
							require("telescope.actions").cycle_history_next(...)
						end,
						["<C-p>"] = function(...)
							require("telescope.actions").cycle_history_prev(...)
						end,
						["<ESC>"] = function(...)
							require("telescope.actions").close(...)
						end,
					},
				},
			},
		},
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)
			telescope.load_extension("fzf")
			telescope.load_extension("file_browser")
			telescope.load_extension("ui-select")
			telescope.load_extension("live_grep_args")
			telescope.load_extension("projects")
		end,
	},
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
				["<leader>f"] = { name = "+File" },
				["<leader>q"] = { cmd = "<cmd>q<cr>", desc = "Quit" },
				["<leader>w"] = { cmd = "<cmd>update!<cr>", desc = "Save" },
			},
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts.setup)
			wk.register(opts.defaults)
		end,
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>fe", "<cmd>Telescope file_browser<cr>", desc = "File Explorer" },
		},
	},
	{ "nvim-telescope/telescope-ui-select.nvim", event = "VeryLazy" },
	{ "nvim-telescope/telescope-live-grep-args.nvim", event = "VeryLazy" },
	{
		"ahmedkhalf/project.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>fp", "<cmd>Telescope projects<cr>", desc = "Projects" },
		},
		config = function()
			require("project_nvim").setup({
				-- Manual mode doesn't automatically change your root directory, so you have
				-- the option to manually do so using `:ProjectRoot` command.
				manual_mode = false,

				-- Methods of detecting the root directory. **"lsp"** uses the native neovim
				-- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
				-- order matters: if one is not detected, the other is used as fallback. You
				-- can also delete or rearangne the detection methods.
				detection_methods = { "lsp", "pattern" },

				-- All the patterns used to detect root dir, when **"pattern"** is in
				-- detection_methods
				patterns = { ".git", ".sln", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", ".csproj" },

				-- Table of lsp clients to ignore by name
				-- eg: { "efm", ... }
				ignore_lsp = {},

				-- Don't calculate root dir on specific directories
				-- Ex: { "~/.cargo/*", ... }
				exclude_dirs = {},

				-- Show hidden files in telescope
				show_hidden = false,

				-- When set to false, you will get a message when project.nvim changes your
				-- directory.
				silent_chdir = false,

				-- What scope to change the directory, valid options are
				-- * global (default)
				-- * tab
				-- * win
				scope_chdir = "global",

				-- Path where project.nvim will store the project history for use in
				-- telescope
				datapath = vim.fn.stdpath("data"),
			})
		end,
	},
	{ "fedepujol/move.nvim", event = "VeryLazy" },
	{ "mg979/vim-visual-multi", event = "VeryLazy" },
	{ "terryma/vim-expand-region", event = "VeryLazy" },
}
