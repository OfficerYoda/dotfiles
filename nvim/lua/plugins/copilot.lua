return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    opts = {
      mappings = {
        reset = {
          -- reset with <C-r> instead of <C-l>
          normal = "<C-r>",
          insert = "<C-r>",
        },
      },
      providers = {
        ollama = {
          -- prepare_input = require("CopilotChat.config.providers").openai.prepare_input,
          -- prepare_output = require("CopilotChat.config.providers").openai.prepare_output,
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
      },
    },
  },
}
