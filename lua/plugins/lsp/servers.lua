local M = {}

local lsp_utils = require("plugins.lsp.utils")

local function lsp_init()
	vim.cmd([[
  highlight! DiagnosticLineNrError guibg=#51202A guifg=#FF0000 gui=bold
  highlight! DiagnosticLineNrWarn guibg=#51412A guifg=#FFA500 gui=bold
  " highlight! DiagnosticLineNrInfo guibg=#1E535D guifg=#00FFFF gui=bold
  " highlight! DiagnosticLineNrHint guibg=#1E205D guifg=#0000FF gui=bold

  sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticLineNrError
  sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticLineNrWarn
  sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticLineNrInfo
  sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticLineNrHint
]])

	-- LSP handlers configuration
	local config = {
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
		},

		diagnostic = {
			virtual_text = {
				severity = {
					min = vim.diagnostic.severity.ERROR,
				},
			},
			underline = false,
			update_in_insert = false,
			severity_sort = true,
			float = {
				focusable = true,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		},
	}

	-- Diagnostic configuration
	vim.diagnostic.config(config.diagnostic)

	-- Hover configuration
	-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, config.float)

	-- Signature help configuration
	-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, config.float)
end

function M.setup(_, opts)
	lsp_utils.on_attach(function(client, bufnr)
		require("plugins.lsp.format").on_attach(client, bufnr)
		require("plugins.lsp.keymaps").on_attach(client, bufnr)
		if client.server_capabilities.signatureHelpProvider then
			require("lsp-overloads").setup(client, {})
		end
	end)

	lsp_init() -- diagnostics, handlers

	local servers = opts.servers
	local capabilities = lsp_utils.capabilities()

	local function setup(server)
		local server_opts = vim.tbl_deep_extend("force", {
			capabilities = capabilities,
		}, servers[server] or {})

		if opts.setup[server] then
			if opts.setup[server](server, server_opts) then
				return
			end
		elseif opts.setup["*"] then
			if opts.setup["*"](server, server_opts) then
				return
			end
		end
		require("lspconfig")[server].setup(server_opts)
	end

	-- get all the servers that are available thourgh mason-lspconfig
	local have_mason, mlsp = pcall(require, "mason-lspconfig")
	local all_mslp_servers = {}
	if have_mason then
		all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
	end

	local ensure_installed = {} ---@type string[]
	for server, server_opts in pairs(servers) do
		if server_opts then
			server_opts = server_opts == true and {} or server_opts
			-- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
			if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
				setup(server)
			else
				ensure_installed[#ensure_installed + 1] = server
			end
		end
	end

	if have_mason then
		mlsp.setup({ ensure_installed = ensure_installed })
		mlsp.setup_handlers({ setup })
	end
end

return M
