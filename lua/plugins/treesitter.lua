return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"joosepalviste/nvim-ts-context-commentstring",
		},
		build = ":tsupdate",
		event = { "bufreadpost", "bufnewfile" },
		opts = {
			sync_install = false,
			ensure_installed = {
				"bash",
				"dockerfile",
				"html",
				"markdown",
				"markdown_inline",
				"org",
				"query",
				"regex",
				"latex",
				"vim",
				"vimdoc",
				"yaml",
			},
			highlight = { enable = true, additional_vim_regex_highlighting = { "org", "markdown" } },
			indent = { enable = true },
			context_commentstring = { enable = true, enable_autocmd = false },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<c-space>",
					node_incremental = "<c-space>",
					scope_incremental = "<c-s>",
					node_decremental = "<c-a-space>",
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true, -- automatically jump forward to textobj, similar to targets.vim
					keymaps = {
						-- you can use the capture groups defined in textobjects.scm
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]f"] = "function",
						["]c"] = "class",
					},
					goto_next_end = {
						["]F"] = "function",
						["]C"] = "class",
					},
					goto_previous_start = {
						["[f"] = "function",
						["[c"] = "class",
					},
					goto_previous_end = {
						["[F"] = "function",
						["[C"] = "class",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>ln"] = "parameter",
						["]a"] = "parameter",
					},
					swap_previous = {
						["<leader>lp"] = "parameter",
						["[a"] = "parameter",
					},
				},
			},
			matchup = {
				enable = true,
			},
		},
		config = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				---@type table<string, boolean>
				local added = {}
				opts.ensure_installed = vim.tbl_filter(function(lang)
					if added[lang] then
						return false
					end
					added[lang] = true
					return true
				end, opts.ensure_installed)
			end
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	-- {
	-- 	"nvim-treesitter/nvim-treesitter-context",
	-- 	config = {
	-- 		enable = false, -- Enable this plugin (Can be enabled/disabled later via commands)
	-- 		max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
	-- 		min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
	-- 		line_numbers = true,
	-- 		multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
	-- 		trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
	-- 		mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
	-- 		-- Separator between context and content. Should be a single character string, like '-'.
	-- 		-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
	-- 		separator = nil,
	-- 		zindex = 20, -- The Z-index of the context window
	-- 		on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
	-- 	},
	-- },
}
