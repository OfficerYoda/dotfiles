return {
  "gbprod/yanky.nvim",
  keys = {
    -- Disable the default mapping
    { "<leader>p", false },
    -- Add the new mapping
    {
      "<leader>y",
      function()
        if LazyVim.pick.picker.name == "telescope" then
          require("telescope").extensions.yank_history.yank_history({})
        elseif LazyVim.pick.picker.name == "snacks" then
          Snacks.picker.yanky()
        else
          vim.cmd([[YankyRingHistory]])
        end
      end,
      mode = { "n", "x" },
      desc = "Open Yank History",
    },
  },
}
