return {
  {
    "mfussenegger/nvim-jdtls",
    opts = {
      settings = {
        java = {
          format = {
            settings = {
              url = vim.fn.expand("~/.config/nvim/eclipse-formatter.xml"),
              profile = "GoogleStyle",
            },
          },
        },
      },
    },
  },
}
