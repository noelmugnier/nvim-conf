if not require("config").pde.ai then
	return {}
end

return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			defaults = {
				["<leader>c"] = { name = "+ChatGPT" },
				["<leader>C"] = { name = "+Copilot" },
			},
		},
	},
	{
		"github/copilot.vim",
		event = "VeryLazy",
		keys = {
			{ "<leader>Ce", "<cmd>Copilot enable<cr>", desc = "Enable copilot" },
			{ "<leader>Cd", "<cmd>Copilot disable<cr>", desc = "Disable copilot" },
			{ "<leader>Cp", "<cmd>Copilot panel<cr>", desc = "Suggestions panel" },
		},
	},
	{
		"jackMort/ChatGPT.nvim",
		event = "VeryLazy",
		config = function()
			require("chatgpt").setup({
				api_key_cmd = "echo $OPENAI_API_KEY",
			})
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		keys = {
			{ "<leader>cc", "<cmd>ChatGPT<cr>", desc = "Chat" },
			{ "<leader>ca", "<cmd>ChatGPTActAs<cr>", desc = "Chat act as" },
			{ "<leader>ce", "<cmd>ChatGPTEditWithInstructions<cr>", desc = "Instruct" },
			{ "<leader>cp", "<cmd>ChatGPTCompleteCode<cr>", desc = "Complete code" },
			{ "<leader>cr", "<cmd>ChatGPTRun<cr>", desc = "+Run" },
			{ "<leader>crt", "<cmd>ChatGPTRun add_tests<cr>", desc = "Add tests" },
			{ "<leader>cra", "<cmd>ChatGPTRun code_readability_analysis<cr>", desc = "Code analysis" },
			{ "<leader>crc", "<cmd>ChatGPTRun complete_code<cr>", desc = "Complete code" },
			{ "<leader>crd", "<cmd>ChatGPTRun docstring<cr>", desc = "Document" },
			{ "<leader>cre", "<cmd>ChatGPTRun explain_code<cr>", desc = "Explain code" },
			{ "<leader>crf", "<cmd>ChatGPTRun fix_bugs<cr>", desc = "Fix bugs" },
			{ "<leader>cro", "<cmd>ChatGPTRun optimize_code<cr>", desc = "Optimize code" },
			{ "<leader>crs", "<cmd>ChatGPTRun summarize<cr>", desc = "Summarize code" },
		},
	},
}
