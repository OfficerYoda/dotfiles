return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    adapters = {
      hai_proxy = function()
        return require("codecompanion.adapters").extend("openai_compatible", {
          name = "hai_proxy",
          env = {
            api_key = "HAI_PROXY_API_KEY",
            url = "http://localhost:6655/litellm/v1",
          },
          schema = {
            model = {
              default = "anthropic--claude-sonnet-latest",
              choices = {
                "anthropic--claude-sonnet-latest",
                "anthropic--claude-opus-latest",
              },
            },
          },
        })
      end,
      ollama = function()
        return require("codecompanion.adapters").extend("ollama", {
          name = "ollama",
          schema = {
            model = {
              default = "qwen3-coder:30b",
            },
          },
          env = {
            url = "http://localhost:11434",
          },
        })
      end,
    },
    strategies = {
      chat = {
        adapter = "hai_proxy", -- default adapter for chat
        keymaps = {
          send = {
            modes = { n = "<CR>", i = "<C-s>" },
          },
          close = {
            modes = { n = "<C-c>", i = "<C-c>" },
          },
        },
      },
      inline = {
        adapter = "hai_proxy",
      },
    },
    display = {
      chat = {
        window = {
          width = 0.4,
          layout = "vertical",
        },
        show_header_separator = true,
      },
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
  config = function(_, opts)
    require("codecompanion").setup(opts)

    -- Disable line numbers in chat buffers (similar to your CopilotChat autocmd)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "codecompanion",
      callback = function()
        vim.opt_local.relativenumber = false
        vim.opt_local.number = false
      end,
    })
  end,
}
