return {
  "folke/which-key.nvim",
  opts = {
    spec = {
      { "<leader>o", group = "obsidian", mode = { "n", "v" }, icon = "" },
      { "<leader>r", group = "run file", mode = { "n", "v" }, icon = "" },
      -- Language specific run commands
      { "<leader>rg", desc = "Go", icon = "" },
      { "<leader>rj", desc = "Java", icon = "" },
      { "<leader>rp", desc = "Prolog", icon = "" },
      -- Additional languages
      -- { "<leader>ry", desc = "Python", icon = "" },
      -- { "<leader>rr", desc = "Rust", icon = "" },
      -- { "<leader>rs", desc = "JavaScript", icon = "" },
      -- { "<leader>rt", desc = "TypeScript", icon = "" },
      -- { "<leader>rc", desc = "C++", icon = "" },
      -- { "<leader>rl", desc = "Lua", icon = "" },
    },
  },
}
