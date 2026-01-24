return {
  "MeanderingProgrammer/render-markdown.nvim",
  opts = {
    -- Override LazyVim's empty icons to use fancy ones
    heading = {
      -- sign = true,
      icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
    },
    -- Re-enable the checkboxes
    checkbox = {
      enabled = true,
    },
    code = {
      -- sign = true,
    },
    latex = {
      enabled = false,
      position = "center",
    },
    render_modes = true,
  },
}
