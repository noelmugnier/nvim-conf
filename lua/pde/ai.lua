if not require("config").pde.ai then
	return {}
end

return {
	{
		"github/copilot.vim",
		event = "VeryLazy",
	},
}
