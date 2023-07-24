return {
  { "nvim-lua/plenary.nvim" },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      defaults = {
      },
    },
  },
  {
    "mrjones2014/legendary.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>p", "<cmd>Legendary<cr>", desc = "Legendary" },
    },
    opts = {
      which_key = { auto_register = true },
      lazy_nvim = { auto_register = true },
    },
  },
  {
        "kdheepak/lazygit.nvim",
    event = "VeryLazy",
        -- optional for floating window border decoration
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("telescope").load_extension("lazygit")
        end,
      -- stylua: ignore
      keys = {
        { "<leader>g", "<cmd>LazyGit<cr>", desc = "Git" },
      },
    },
}
