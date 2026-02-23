return {
  "nvim-telescope/telescope.nvim",
  -- Stop LazyVim from automatically mapping <leader>ff, <leader>/, etc. to Telescope
  keys = function()
    return {}
  end,
  -- Basic configuration so it's ready for your other plugin
  opts = {
    defaults = {
      mappings = {
        i = {
          ["<C-j>"] = "move_selection_next",
          ["<C-k>"] = "move_selection_previous",
        },
      },
    },
  },
}
