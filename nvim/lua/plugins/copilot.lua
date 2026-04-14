return {
  "CopilotC-Nvim/CopilotChat.nvim",
  opts = {
    mappings = {
      reset = {
        -- reset with <C-r> instead of <C-l>
        normal = "<C-r>",
        insert = "<C-r>",
      },
    },
    model = "anthropic--claude-sonnet-latest",
    providers = {
      ollama = {
        prepare_input = require("CopilotChat.config.providers").copilot.prepare_input,
        prepare_output = require("CopilotChat.config.providers").copilot.prepare_output,
        get_url = function()
          return "http://localhost:11434/v1/chat/completions"
        end,
        get_models = function()
          return {
            {
              id = "qwen3-coder:30b", -- Ensure this matches your 'ollama list' name
              name = "Qwen3 Coder 30B",
            },
          }
        end,
      },
      hai_proxy = {
        -- Replace with your LiteLLM endpoint
        get_url = function()
          return "http://localhost:6655/litellm/v1/chat/completions"
        end,
        -- Set your local API key
        get_headers = function()
          return {
            ["Authorization"] = "Bearer " .. (os.getenv("HAI_PROXY_API_KEY") or ""),
          }
        end,
        -- List the models available via your proxy
        get_models = function()
          return {
            { id = "anthropic--claude-sonnet-latest", name = "Proxy Sonnet latest" },
            { id = "anthropic--claude-opus-latest", name = "Proxy Opus latest" },
          }
        end,
        -- Use the standard OpenAI/Copilot formatting logic
        prepare_input = require("CopilotChat.config.providers").copilot.prepare_input,
        prepare_output = require("CopilotChat.config.providers").copilot.prepare_output,
      },
    },
  },
  keys = {
    { "<leader>am", "<cmd>CopilotChatModels<cr>", desc = "Change Copilt-Chat Models" },
  },
}
