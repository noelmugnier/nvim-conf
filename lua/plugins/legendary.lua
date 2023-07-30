return {
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
}
