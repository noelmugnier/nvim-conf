if not require("config").pde.csharp then
	return {}
end

return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "c_sharp" })
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "netcoredbg" })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#omnisharp
				omnisharp = {
					organize_imports_on_format = true,
					enable_import_completion = true,
					enable_editorconfig_support = true,
					enable_roslyn_analyzers = true,
					handlers = {
						["textDocument/definition"] = require("omnisharp_extended").handler,
					},
				},
			},
			setup = {
				omnisharp = function()
					local lsp_utils = require("base.lsp.utils")
					lsp_utils.on_attach(function(client, bufnr)
						if client.name == "omnisharp" then
							local map = function(mode, lhs, rhs, desc)
								if desc then
									desc = desc
								end
								vim.keymap.set(
									mode,
									lhs,
									rhs,
									{ silent = true, desc = desc, buffer = bufnr, noremap = true }
								)
							end

							map("n", "gd", function()
								require("omnisharp_extended").telescope_lsp_definitions({ reuse_win = true })
							end, "Goto Definition")

							-- https://github.com/OmniSharp/omnisharp-roslyn/issues/2483
							local function toSnakeCase(str)
								return string.gsub(str, "%s*[- ]%s*", "_")
							end

							local tokenModifiers =
								client.server_capabilities.semanticTokensProvider.legend.tokenModifiers
							for i, v in ipairs(tokenModifiers) do
								tokenModifiers[i] = toSnakeCase(v)
							end
							local tokenTypes = client.server_capabilities.semanticTokensProvider.legend.tokenTypes
							for i, v in ipairs(tokenTypes) do
								tokenTypes[i] = toSnakeCase(v)
							end

              -- C# keymappings
              -- stylua: ignore
              map("n","<leader>td","<cmd>w|lua require('neotest').run.run({vim.fn.expand('%'), strategy = require('neotest-dotnet.strategies.netcoredbg'), is_custom_dotnet_debug = true})<cr>", "Debug File")

              -- stylua: ignore
              map("n","<leader>tL","<cmd>w|lua require('neotest').run.run_last({strategy = require('neotest-dotnet.strategies.netcoredbg'), is_custom_dotnet_debug = true})<cr>", "Debug Last")

              -- stylua: ignore
              map("n","<leader>tN","<cmd>w|lua require('neotest').run.run({strategy = require('neotest-dotnet.strategies.netcoredbg'), is_custom_dotnet_debug = true})<cr>", "Debug Nearest")
						end
					end)
				end,
			},
		},
	},
	{
		"mfussenegger/nvim-dap",
		opts = {
			setup = {
				netcoredbg = function(_, _)
					local dap = require("dap")

					local function get_debugger()
						local mason_registry = require("mason-registry")
						local debugger = mason_registry.get_package("netcoredbg")
						return debugger:get_install_path() .. "/netcoredbg"
					end

					vim.g.dotnet_build_project = function()
						local default_path = vim.fn.getcwd() .. "/"
						if vim.g["dotnet_last_proj_path"] ~= nil then
							default_path = vim.g["dotnet_last_proj_path"]
						end
						local path = vim.fn.input("Path to your *proj file", default_path, "file")
						vim.g["dotnet_last_proj_path"] = path
						local cmd = "dotnet build -c Debug " .. path .. " > /dev/null"
						print("")
						print("Cmd to execute: " .. cmd)
						local f = os.execute(cmd)
						if f == 0 then
							print("\nBuild: ✔️ ")
						else
							print("\nBuild: ❌ (code: " .. f .. ")")
						end
					end

					vim.g.dotnet_get_dll_path = function()
						local request = function()
							return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
						end

						if vim.g["dotnet_last_dll_path"] == nil then
							vim.g["dotnet_last_dll_path"] = request()
						else
							if
								vim.fn.confirm(
									"Do you want to change the path to dll?\n" .. vim.g["dotnet_last_dll_path"],
									"&yes\n&no",
									2
								) == 1
							then
								vim.g["dotnet_last_dll_path"] = request()
							end
						end

						return vim.g["dotnet_last_dll_path"]
					end

					dap.configurations.cs = {
						{
							type = "coreclr",
							name = "launch - netcoredbg",
							request = "launch",
							program = function()
								if vim.fn.confirm("Should I recompile first?", "&yes\n&no", 2) == 1 then
									vim.g.dotnet_build_project()
								end
								return vim.g.dotnet_get_dll_path()
							end,
						},
					}
					dap.adapters.coreclr = {
						type = "executable",
						command = get_debugger(),
						args = { "--interpreter=vscode" },
					}
					dap.adapters.netcoredbg = {
						type = "executable",
						command = get_debugger(),
						args = { "--interpreter=vscode" },
					}
				end,
			},
		},
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			"Issafalcon/neotest-dotnet",
		},
		opts = function(_, opts)
			vim.list_extend(opts.adapters, {
				require("neotest-dotnet")({
					dap = { justMyCode = false },
					-- Provide any additional "dotnet test" CLI commands here. These will be applied to ALL test runs performed via neotest. These need to be a table of strings, ideally with one key-value pair per item.
					dotnet_additional_args = {
						"--verbosity detailed",
						"--configuration DEBUG",
					},
					-- Tell neotest-dotnet to use either solution (requires .sln file) or project (requires .csproj or .fsproj file) as project root
					-- Note: If neovim is opened from the solution root, using the 'project' setting may sometimes find all nested projects, however,
					--       to locate all test projects in the solution more reliably (if a .sln file is present) then 'solution' is better.
					discovery_root = "project", -- Default
				}),
			})
		end,
	},
}
