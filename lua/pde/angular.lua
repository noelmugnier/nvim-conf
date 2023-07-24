if not require("config").pde.angular then
  return {}
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        angularls = {},
      },
    },
  },
}
