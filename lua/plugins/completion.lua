return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
		},
		opts = function()
			local cmp = require("cmp")
			cmp.setup({
				preselect = cmp.PreselectMode.None,
			})

			local luasnip = require("luasnip")
			local compare = require("cmp.config.compare")
			local source_names = {
				luasnip = "(Snippet)",
				nvim_lsp = "(LSP)",
				buffer = "(Buffer)",
				path = "(Path)",
			}
			local duplicates = {
				buffer = 1,
				path = 1,
				nvim_lsp = 0,
				luasnip = 1,
			}
			local has_words_before = function()
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end
			local cmp_window = require("cmp.config.window")
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
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					-- ["<C-b>"] = cmp.mapping.scroll_docs(-4),
					-- ["<C-f>"] = cmp.mapping.scroll_docs(4),
					-- ["<C-Space>"] = cmp.mapping.complete(),
					-- ["<C-e>"] = cmp.mapping.abort(),
					-- ["<CR>"] = cmp.mapping({
					-- 	i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
					-- 	c = function(fallback)
					-- 		if cmp.visible() then
					-- 			cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
					-- 		else
					-- 			fallback()
					-- 		end
					-- 	end,
					-- }),
					-- ["<C-j>"] = cmp.mapping(function(fallback)
					-- 	if cmp.visible() then
					-- 		cmp.select_next_item()
					-- 	elseif luasnip.expand_or_jumpable() then
					-- 		luasnip.expand_or_jump()
					-- 	elseif has_words_before() then
					-- 		cmp.complete()
					-- 	else
					-- 		fallback()
					-- 	end
					-- end, {
					-- 	"i",
					-- 	"s",
					-- 	"c",
					-- }),
					-- ["<C-k>"] = cmp.mapping(function(fallback)
					-- 	if cmp.visible() then
					-- 		cmp.select_prev_item()
					-- 	elseif luasnip.jumpable(-1) then
					-- 		luasnip.jump(-1)
					-- 	else
					-- 		fallback()
					-- 	end
					-- end, {
					-- 	"i",
					-- 	"s",
					-- 	"c",
					-- }),
					["<Up>"] = cmp.mapping.select_prev_item(),
					["<Down>"] = cmp.mapping.select_next_item(),
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
					["<C-Space>"] = cmp.mapping(
						cmp.mapping.complete({
							reason = cmp.ContextReason.Auto,
						}),
						{ "i", "c" }
					),
					["<CR>"] = cmp.mapping({
						-- i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
						i = function(fallback)
							if cmp.visible() then
								cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
							else
								fallback()
							end
						end,
						c = function(fallback)
							if cmp.visible() then
								cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
							else
								fallback()
							end
						end,
					}),
					["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
					-- ["<esc>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i" }),
				}),
				sources = cmp.config.sources({
					{ name = "luasnip", group_index = 1 },
					{ name = "nvim_lsp", group_index = 2 },
					{ name = "buffer", group_index = 3 },
					{ name = "path", group_index = 3 },
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
				performance = {
					debounce = 26,
					throttle = 48,
					fetching_timeout = 200,
					async_budget = 50,
					max_view_entries = 32,
				},
				window = {
					completion = cmp_window.bordered(),
					documentation = cmp_window.bordered(),
				},
				-- experimental = {
				-- 	hl_group = "LspCodeLens",
				-- 	ghost_text = {},
				-- },
				-- window = {
				-- 	documentation = {
				-- 		border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
				-- 		winhighlight = "NormalFloat:NormalFloat,FloatBorder:TelescopeBorder",
				-- 	},
				-- },
			}
		end,
	},
}
