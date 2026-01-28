return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        marksman = {
          enabled = false, -- This prevents LazyVim from starting Marksman
        },
      },
    },
  },
}
