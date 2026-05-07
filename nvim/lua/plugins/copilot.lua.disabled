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
        get_url = function()
          return "http://localhost:11434/v1/chat/completions"
        end,
        get_models = function()
          return {
            { id = "qwen3-coder:30b", name = "Qwen3 Coder 30B", streaming = true },
          }
        end,
        prepare_input = require("CopilotChat.config.providers").copilot.prepare_input,
        prepare_output = require("CopilotChat.config.providers").copilot.prepare_output,
      },
      hai_proxy = {
        get_url = function()
          return "http://localhost:6655/litellm/v1/chat/completions"
        end,
        get_headers = function()
          return {
            ["Authorization"] = "Bearer " .. (os.getenv("HAI_PROXY_API_KEY") or ""),
          }
        end,
        get_models = function()
          return {
            { id = "anthropic--claude-sonnet-latest", name = "Proxy Sonnet latest", streaming = true },
            { id = "anthropic--claude-opus-latest", name = "Proxy Opus latest", streaming = true },
          }
        end,
        prepare_input = require("CopilotChat.config.providers").copilot.prepare_input,
        prepare_output = require("CopilotChat.config.providers").copilot.prepare_output,
      },
    },
  },
  keys = {
    { "<leader>am", "<cmd>CopilotChatModels<cr>", desc = "Change Copilt-Chat Models" },
  },
}
