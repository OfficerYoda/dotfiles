return {
  {
    "mfussenegger/nvim-jdtls",
    opts = function(_, opts)
      -- Run the language server on Java 21 independently of the project's JDK.
      table.insert(opts.cmd, "--java-executable=/usr/lib/jvm/java-21-openjdk/bin/java")
      opts.settings = vim.tbl_deep_extend("force", opts.settings or {}, {
        java = {
          format = {
            settings = {
              url = vim.fn.expand("~/.config/nvim/eclipse-formatter.xml"),
              profile = "GoogleStyle",
            },
          },
        },
      })
    end,
  },
}
