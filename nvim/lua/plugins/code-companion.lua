return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    -- Load only when you use these commands
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
    opts = {
      interactions = {
        chat = { adapter = "ollama", model = "qwen3-coder:30b" },
        inline = { adapter = "ollama", model = "qwen3-coder:30b" },
        cmd = { adapter = "ollama", model = "qwen3-coder:30b" },
      },
      adapters = {
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            schema = {
              model = { default = "qwen3-coder:30b" },
            },
          })
        end,
      },
    },
  },
}
