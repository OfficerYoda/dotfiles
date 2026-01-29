return {
  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy", -- Only load after the UI is ready
    opts = {
      stiffness = 0.8,
      trailing_stiffness = 0.79,
      never_draw_over_target = false,
    },
  },
}
