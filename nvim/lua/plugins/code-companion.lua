return {
  "olimorris/codecompanion.nvim",
  version = "^19.0.0",
  opts = {},
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
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
