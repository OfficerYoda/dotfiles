return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        marksman = {
          enabled = true, -- This prevents LazyVim from starting Marksman
        },
      },
    },
  },
}
