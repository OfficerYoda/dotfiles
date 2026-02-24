return {
  {
    "mfussenegger/nvim-jdtls",
    opts = {
      -- This tells jdtls to treat 'src' as a source folder even without a pom.xml/build.gradle
      settings = {
        java = {
          project = {
            sourcePaths = { "src" },
          },
        },
      },
    },
  },
}
