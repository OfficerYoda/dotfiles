local is_work = vim.fn.hostname():find("work") ~= nil

return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    { "zbirenbaum/copilot.lua", enabled = not is_work }, -- Disable Copilot at work
  },
  opts = {
    strategies = {
      chat = { adapter = is_work and "ollama" or "copilot" },
      inline = { adapter = is_work and "ollama" or "copilot" },
    },
    adapters = {
      -- Your custom Work Proxy
      hai_proxy = function()
        return require("codecompanion.adapters").use("openai", {
          url = "http://localhost:6655/litellm/v1/chat/completions",
          env = { api_key = "HAI_PROXY_API_KEY" }, -- Plugin looks for this env var
          schema = {
            model = { default = "anthropic--claude-sonnet-latest" },
          },
        })
      end,
      -- Your Ollama setup
      ollama = function()
        return require("codecompanion.adapters").use("ollama", {
          schema = {
            model = { default = "qwen3-coder:30b" },
          },
        })
      end,
    },
  },
  -- keys = {
  --   { "<leader>aa", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "AI Actions" },
  --   { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "AI Chat" },
  -- },
}
