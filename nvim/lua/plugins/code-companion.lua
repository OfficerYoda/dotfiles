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
        },
        litellm = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              url = "http://localhost:6655/litellm",
              api_key = os.getenv("HAI_PROXY_API_KEY") or "",
              chat_url = "/v1/chat/completions",
              models_endpoint = "/v1/models",
            },
          })
        end,
        litellm_anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            url = "http://localhost:6655/anthropic/v1/messages",
            env = {
              api_key = os.getenv("HAI_PROXY_API_KEY") or "",
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
      "<leader>ax",
      function()
        -- Reset/clear the current chat
        local chat = require("codecompanion").last_chat()
        if chat then
          chat:reset()
        end
      end,
      desc = "Clear (CodeCompanion)",
      mode = { "n", "x" },
    },
    {
      "<leader>aq",
      function()
        vim.ui.input({
          prompt = "Quick Chat: ",
        }, function(input)
          if input and input ~= "" then
            require("codecompanion").chat(input)
          end
        end)
      end,
      desc = "Quick Chat (CodeCompanion)",
      mode = { "n", "x" },
    },
    {
      "<leader>ap",
      "<cmd>CodeCompanionActions<cr>",
      desc = "Prompt Actions (CodeCompanion)",
      mode = { "n", "x" },
    },
    {
      "<leader>am",
      function()
        -- Switch adapters/models
        vim.ui.select({ "hai_proxy", "ollama" }, {
          prompt = "Select adapter:",
        }, function(choice)
          if choice then
            local chat = require("codecompanion").last_chat()
            if chat then
              chat.adapter = require("codecompanion.adapters").resolve(choice)
            end
          end
        end)
      end,
      desc = "Change CodeCompanion Model",
    },
  },
}
