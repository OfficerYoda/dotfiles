return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        json = { "prettier" }, -- Ensure JSON uses prettier
        jsonc = { "prettier" }, -- Also for JSON with comments
      },
      formatters = {
        prettier = {
          prepend_args = {
            "--prose-wrap",
            "always",
            "--print-width",
            "80",
            "--trailing-comma",
            "none",
          },
        },
      },
    },
  },
}
