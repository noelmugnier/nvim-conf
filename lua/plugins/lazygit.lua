return {
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
      { "<leader>G", "<cmd>LazyGit<cr>", desc = "Git" },
    },
  },
}
