return {
  "neovim/nvim-lspconfig",
  ft = "prolog",
  opts = function(_, opts)
    opts.servers = opts.servers or {}
    opts.servers.prolog_lsp = {
      -- This tells nvim-lspconfig how to start the server you just installed
      cmd = {
        "swipl",
        "-g",
        "use_module(library(lsp_server)).",
        "-g",
        "lsp_server:main",
        "-t",
        "halt",
        "--",
        "stdio",
      },
      filetypes = { "prolog" },
      root_dir = require("lspconfig.util").root_pattern("pack.pl", ".git"),
    }
  end,
}
