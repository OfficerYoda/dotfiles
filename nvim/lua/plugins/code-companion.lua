return {
  "olimorris/codecompanion.nvim",
  version = "^19.0.0",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    adapters = {
      http = {
        opts = {
          allow_insecure = true,
          show_model_choices = true, -- default, but explicit for clarity
        },
        litellm = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              url = "http://localhost:6655/litellm",
              api_key = os.getenv("HAI_PROXY_API_KEY") or "",
              chat_url = "/v1/chat/completions",
              models_endpoint = "/v1/models",
            },
            schema = {
              model = {
                default = "anthropic--claude-4.5-haiku",
                choices = {
                  "anthropic--claude-4.5-haiku",
                  "anthropic--claude-4.6-sonnet",
                  "anthropic--claude-4.6-opus",
                },
              },
            },
          })
        end,
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            env = {
              url = "http://localhost:11434",
            },
            schema = {
              model = {
                default = "qwen3.6:35b-a3b-coding-nvfp4",
              },
            },
          })
        end,
      },
    },
    interactions = {
      chat = { adapter = "litellm" },
      inline = { adapter = "litellm" },
    },
  },
  keys = {
    { "<leader>a", "", desc = "+ai", mode = { "n", "x" } },
    {
      "<leader>aa",
      "<cmd>CodeCompanionChat Toggle<cr>",
      desc = "Toggle (CodeCompanion)",
      mode = { "n", "x" },
    },
    {
      "<leader>ap",
      "<cmd>CodeCompanionActions<cr>",
      desc = "Prompt Actions (CodeCompanion)",
      mode = { "n", "x" },
    },
  },
}
