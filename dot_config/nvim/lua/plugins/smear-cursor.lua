return {
  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy", -- Only load after the UI is ready
    opts = {
      stiffness = 0.8,
      trailing_stiffness = 0.5,
      distance_stop_animating = 0.5,
    },
  },
}
