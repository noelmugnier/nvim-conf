return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			defaults = {
				["<leader>f"] = { name = "+Files" },
			},
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		cmd = "Telescope",
    -- stylua: ignore
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>",     desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope git_files<cr>",      desc = "Git Files" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>",        desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>",      desc = "Help" },
      { "<leader>fs", "<cmd>Telescope live_grep_args<cr>", desc = "Search files content" },
      { "<leader>fw", "<cmd>Telescope grep_string<cr>",    desc = "Search current word" },
      { "<leader>fd", "<cmd>Telescope diagnostics<cr>",    desc = "Search Diagnostics" },
      { "<leader>fr", function()
            require('telescope').extensions.recent_files.pick() end,       desc = "Previous Files" },
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
						["<C-t>"] = function(...)
							require("trouble.providers.telescope").open_with_trouble(...)
						end,
						["<ESC>"] = function(...)
							require("telescope.actions").close(...)
						end,
					},
					n = {
						["<C-t>"] = function(...)
							require("trouble.providers.telescope").open_with_trouble(...)
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
			telescope.load_extension("recent_files")
		end,
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>fe", "<cmd>Telescope file_browser<cr>", desc = "File Browser" },
		},
	},
	{ "nvim-telescope/telescope-ui-select.nvim" },
	{ "nvim-telescope/telescope-live-grep-args.nvim" },
	{ "smartpde/telescope-recent-files" },
}
