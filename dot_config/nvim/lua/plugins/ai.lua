return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      interactions = {
        chat = {
          adapter = "copilot",
          model = "claude-sonnet-4-20250514",
        },
      },
      opts = {
        log_level = "DEBUG",
      },
    },
  },
}
