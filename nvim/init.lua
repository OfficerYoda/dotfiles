-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Time in ms to wait for a KEY CODE sequence (like Escape codes) to complete
-- Setting this low fixes the "Laggy Esc" which leads to "Accidental Alt" issue
vim.opt.ttimeoutlen = 2

-- local highlight_groups = {
--   "Normal",
--   "NormalNC",
--   "LineNr",
--   "Folded",
--   "NonText",
--   "SpecialKey",
--   "VertSplit",
--   "SignColumn",
--   "EndOfBuffer",
-- }
--
-- for _, group in ipairs(highlight_groups) do
--   vim.api.nvim_set_hl(0, group, { bg = "none", ctermbg = "none" })
-- end

-- obsidian.nvim autocomplete fix (https://github.com/orgs/obsidian-nvim/discussions/200)
require("blink.cmp").setup({
  sources = {
    per_filetype = {
      markdown = { inherit_defaults = true },
    },
  },
})
