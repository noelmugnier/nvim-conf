return {
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		opts = {},
	},
	{
		"numToStr/Comment.nvim",
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
		keys = { { "gc", mode = { "n", "v" } }, { "gcc", mode = { "n", "v" } }, { "gbc", mode = { "n", "v" } } },
		config = function(_, _)
			local opts = {
				ignore = "^$",
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			}
			require("Comment").setup(opts)
		end,
	},
	{
		"andymass/vim-matchup",
		event = { "BufReadPost" },
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end,
	},
	{
		"RRethy/vim-illuminate",
		event = "BufReadPost",
		opts = { delay = 200 },
		config = function(_, opts)
			require("illuminate").configure(opts)
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
		},
		opts = function()
			local cmp = require("cmp")
			local compare = require("cmp.config.compare")
			local source_names = {
				nvim_lsp = "(LSP)",
				buffer = "(Buffer)",
				path = "(Path)",
			}
			local duplicates = {
				buffer = 1,
				path = 1,
				nvim_lsp = 0,
			}
			local has_words_before = function()
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			return {
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				sorting = {
					priority_weight = 2,
					comparators = {
						compare.score,
						compare.recently_used,
						compare.offset,
						compare.exact,
						compare.kind,
						compare.sort_text,
						compare.length,
						compare.order,
					},
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping({
						i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
						c = function(fallback)
							if cmp.visible() then
								cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
							else
								fallback()
							end
						end,
					}),
					["<C-j>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, {
						"i",
						"s",
						"c",
					}),
					["<C-k>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end, {
						"i",
						"s",
						"c",
					}),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp", group_index = 1 },
					{ name = "buffer", group_index = 2 },
					{ name = "path", group_index = 2 },
				}),
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, item)
						local duplicates_default = 0
						item.menu = source_names[entry.source.name]
						item.dup = duplicates[entry.source.name] or duplicates_default
						return item
					end,
				},
				experimental = {
					hl_group = "LspCodeLens",
					ghost_text = {},
				},
				window = {
					documentation = {
						border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
						winhighlight = "NormalFloat:NormalFloat,FloatBorder:TelescopeBorder",
					},
				},
			}
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			defaults = {
				["<leader>t"] = { name = "+Test" },
			},
		},
	},
	{
		"vim-test/vim-test",
		opts = {
			setup = {},
		},
		config = function(plugin, opts)
			vim.g["test#strategy"] = "neovim"
			vim.g["test#neovim#term_position"] = "belowright"
			vim.g["test#neovim#preserve_screen"] = 1

			-- Set up vim-test
			for k, _ in pairs(opts.setup) do
				opts.setup[k](plugin, opts)
			end
		end,
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-vim-test",
			"vim-test/vim-test",
			"stevearc/overseer.nvim",
		},
		keys = {
			{
				"<leader>td",
				"<cmd>w|lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>",
				desc = "Debug File",
			},
			{ "<leader>tL", "<cmd>w|lua require('neotest').run.run_last({strategy = 'dap'})<cr>", desc = "Debug Last" },
			{ "<leader>ta", "<cmd>w|lua require('neotest').run.attach()<cr>", desc = "Attach" },
			{ "<leader>tf", "<cmd>w|lua require('neotest').run.run(vim.fn.expand('%'))<cr>", desc = "File" },
			{ "<leader>tF", "<cmd>w|lua require('neotest').run.run(vim.loop.cwd())<cr>", desc = "All Files" },
			{ "<leader>tl", "<cmd>w|lua require('neotest').run.run_last()<cr>", desc = "Last" },
			{ "<leader>tn", "<cmd>w|lua require('neotest').run.run()<cr>", desc = "Nearest" },
			{ "<leader>tN", "<cmd>w|lua require('neotest').run.run({strategy = 'dap'})<cr>", desc = "Debug Nearest" },
			{ "<leader>to", "<cmd>w|lua require('neotest').output.open({ enter = true })<cr>", desc = "Output" },
			{ "<leader>ts", "<cmd>w|lua require('neotest').run.stop()<cr>", desc = "Stop" },
			{ "<leader>tS", "<cmd>w|lua require('neotest').summary.toggle()<cr>", desc = "Summary" },
		},
		opts = function()
			return {
				adapters = {
					require("neotest-vim-test")({
						ignore_file_types = { "python", "vim", "lua" },
					}),
				},
				status = { virtual_text = true },
				output = { open_on_run = true },
				-- overseer.nvim
				consumers = {
					overseer = require("neotest.consumers.overseer"),
				},
				overseer = {
					enabled = true,
					force_default = true,
				},
			}
		end,
		config = function(_, opts)
			local neotest_ns = vim.api.nvim_create_namespace("neotest")
			vim.diagnostic.config({
				virtual_text = {
					format = function(diagnostic)
						local message =
							diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
						return message
					end,
				},
			}, neotest_ns)
			require("neotest").setup(opts)
		end,
	},
	{
		"echasnovski/mini.hipatterns",
		event = "BufReadPre",
		opts = function()
			local hi = require("mini.hipatterns")
			return {
				highlighters = {
					hex_color = hi.gen_highlighter.hex_color({ priority = 2000 }),
				},
			}
		end,
	},
	{
		"echasnovski/mini.ai",
		event = "VeryLazy",
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
		opts = function()
			local ai = require("mini.ai")
			return {
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter({
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}, {}),
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
				},
			}
		end,
		config = function(_, opts)
			require("mini.ai").setup(opts)
			if require("utils").has("which-key.nvim") then
				---@type table<string, string|table>
				local i = {
					[" "] = "Whitespace",
					['"'] = 'Balanced "',
					["'"] = "Balanced '",
					["`"] = "Balanced `",
					["("] = "Balanced (",
					[")"] = "Balanced ) including white-space",
					[">"] = "Balanced > including white-space",
					["<lt>"] = "Balanced <",
					["]"] = "Balanced ] including white-space",
					["["] = "Balanced [",
					["}"] = "Balanced } including white-space",
					["{"] = "Balanced {",
					["?"] = "User Prompt",
					_ = "Underscore",
					a = "Argument",
					b = "Balanced ), ], }",
					c = "Class",
					f = "Function",
					o = "Block, conditional, loop",
					q = "Quote `, \", '",
					t = "Tag",
				}
				local a = vim.deepcopy(i)
				for k, v in pairs(a) do
					a[k] = v:gsub(" including.*", "")
				end

				local ic = vim.deepcopy(i)
				local ac = vim.deepcopy(a)
				for key, name in pairs({ n = "Next", l = "Last" }) do
					i[key] = vim.tbl_extend("force", { name = "Inside " .. name .. " textobject" }, ic)
					a[key] = vim.tbl_extend("force", { name = "Around " .. name .. " textobject" }, ac)
				end
				require("which-key").register({
					mode = { "o", "x" },
					i = i,
					a = a,
				})
			end
		end,
	},
	{
		"github/copilot.vim",
		event = "VeryLazy",
	},
}
