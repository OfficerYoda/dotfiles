return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    -- keys = {
    --   { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Toggle AI Chat" },
    --   { "<leader>aq", "<cmd>CodeCompanion<cr>", mode = { "n", "v" }, desc = "Quick AI Action" },
    -- },
    opts = {
      interactions = {
        chat = { adapter = "copilot" },
        inline = { adapter = "copilot" },
        cmd = { adapter = "copilot" },
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
