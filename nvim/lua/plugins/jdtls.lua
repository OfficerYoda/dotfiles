return {
  {
    "mfussenegger/nvim-jdtls",
    opts = function(_, opts)
      -- Select the server's JDK independently of the project's JDK.
      local java_home = "/usr/lib/jvm/java-21-openjdk"
      if vim.fn.has("mac") == 1 then
        java_home = vim.trim(vim.fn.system({ "mise", "where", "java@25" }))
        assert(vim.v.shell_error == 0, "jdtls requires Java 25 installed through mise")
      end
      table.insert(opts.cmd, "--java-executable=" .. java_home .. "/bin/java")
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
