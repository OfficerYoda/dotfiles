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
    model = "auto",
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
              name = "Qwen Coder 30B",
            },
          }
        end,
      },
      proxy_ai = {
        -- Replace with your LiteLLM endpoint
        get_url = function()
          return "http://localhost:6655/litellm/v1/chat/completions"
        end,
        -- Set your local API key
        get_headers = function()
          return {
            ["Authorization"] = "Bearer YOUR_API_KEY",
          }
        end,
        -- List the models available via your proxy
        get_models = function()
          return {
            { id = "gpt-4", name = "Proxy GPT-4" },
            { id = "claude-3", name = "Proxy Claude" },
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
