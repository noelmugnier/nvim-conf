return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"meuter/lualine-so-fancy.nvim",
		},
		event = "VeryLazy",
		opts = function()
			return {
				options = {
					icons_enabled = true,
					theme = "auto",
					component_separators = {},
					section_separators = {},
					disabled_filetypes = {
						statusline = { "alpha", "lazy", "fugitive", "" },
						winbar = {
							"help",
							"alpha",
							"lazy",
						},
					},
					always_divide_middle = true,
					globalstatus = true,
				},
				sections = {
					lualine_a = { { "fancy_mode", width = 3 } },
					lualine_b = {
						{
							function()
								local results = {}
								local job = Job:new({
									command = "git",
									args = { "rev-parse", "--show-toplevel" },
									cwd = vim.fn.expand("%:p:h"),
									on_stdout = function(_, line)
										table.insert(results, line)
									end,
								})
								job:sync()
								if results[1] ~= nil then
									return vim.fn.fnamemodify(results[1], ":t")
								else
									return ""
								end
							end,
						},
						"branch",
					},
					lualine_c = {
						"filename",
						{ "fancy_cwd", substitute_home = true },
						{
							"diff",
							source = function()
								local gitsigns = vim.b.gitsigns_status_dict
								if gitsigns then
									return {
										added = gitsigns.added,
										modified = gitsigns.changed,
										removed = gitsigns.removed,
									}
								end
							end,
						},
						{ "fancy_diagnostics" },
						-- { require("NeoComposer.ui").status_recording },
						{
							function()
								return "%="
							end,
						},
						{
							function(msg)
								msg = msg or ""
								local buf_clients = vim.lsp.get_active_clients({ bufnr = 0 })

								if next(buf_clients) == nil then
									if type(msg) == "boolean" or #msg == 0 then
										return ""
									end
									return msg
								end

								local buf_ft = vim.bo.filetype
								local buf_client_names = {}

								-- add client
								for _, client in pairs(buf_clients) do
									if client.name ~= "null-ls" then
										table.insert(buf_client_names, client.name)
									end
								end

								-- add formatter
								local lsp_utils = require("plugins.lsp.utils")
								local formatters = lsp_utils.list_formatters(buf_ft)
								vim.list_extend(buf_client_names, formatters)

								-- add linter
								local linters = lsp_utils.list_linters(buf_ft)
								vim.list_extend(buf_client_names, linters)

								-- add hover
								local hovers = lsp_utils.list_hovers(buf_ft)
								vim.list_extend(buf_client_names, hovers)

								-- add code action
								local code_actions = lsp_utils.list_code_actions(buf_ft)
								vim.list_extend(buf_client_names, code_actions)

								local hash = {}
								local client_names = {}
								for _, v in ipairs(buf_client_names) do
									if not hash[v] then
										client_names[#client_names + 1] = v
										hash[v] = true
									end
								end
								table.sort(client_names)
								return icons.ui.Code .. " " .. table.concat(client_names, ", ") .. " " .. icons.ui.Code
							end,
							-- icon = icons.ui.Code,
							colored = true,
							on_click = function()
								vim.cmd([[LspInfo]])
							end,
						},
					},
					lualine_x = {
						"encoding",
						"fileformat",
						"filetype",
						"progress",
					},
					lualine_y = {},
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				extensions = { "nvim-tree", "quickfix" },
			}
		end,
	},
}
