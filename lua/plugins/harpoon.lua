return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			defaults = {
				["<leader>h"] = { name = "+Harpoon" },
			},
		},
	},
	{
		"ThePrimeagen/harpoon",
    --stylua: ignore
    keys = {
      { "<leader>ha", function() require("harpoon.mark").add_file() end,            desc = "Add File" },
      { "<leader>hm", function() require("harpoon.ui").toggle_quick_menu() end,     desc = "File Menu" },
      { "<leader>hc", function() require("harpoon.cmd-ui").toggle_quick_menu() end, desc = "Command Menu" },
      { "<A-1>",      function() require("harpoon.ui").nav_file(1) end,             desc = "File 1" },
      { "<A-2>",      function() require("harpoon.ui").nav_file(2) end,             desc = "File 2" },
      { "<A-3>",      function() require("harpoon.ui").nav_file(3) end,             desc = "File 3" },
      { "<A-4>",      function() require("harpoon.ui").nav_file(4) end,             desc = "File 4" },
      { "<A-5>",      function() require("harpoon.ui").nav_file(5) end,             desc = "File 5" },
    },
		opts = {
			global_settings = {
				save_on_toggle = true,
				enter_on_sendcmd = true,
			},
		},
	},
}
