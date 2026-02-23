return {
  "3rd/diagram.nvim",
  enabled = false,
  dependencies = {
    { "3rd/image.nvim" },
  },
  ft = { "markdown", "mermaid" },
  opts = {
    events = {
      render_buffer = { "InsertLeave", "BufWinEnter", "TextChanged" },
      clear_buffer = { "BufLeave" },
    },
    renderer_options = {
      mermaid = {
        background = "transparent", -- nil | "transparent" | "white" | "#hex"
        theme = "dark", -- nil | "default" | "dark" | "forest" | "neutral"
      },
    },
  },
}
