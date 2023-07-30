return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      disable_filetype = { "TelescopePrompt", "vim" },
    },
    config = function()
      local npairs = require("nvim-autopairs")
      npairs.setup({
        check_ts = true,
      })
    end,
  },
}
