-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.relativenumber = true
vim.opt.winbar = "%=%m %f"

-- Enable spell checking
vim.opt.spell = true
-- Set spell languages to US English and German
vim.opt.spelllang = "en_us,de"

-- Set soft wrap options
-- vim.opt.wrap = true
vim.opt.textwidth = 120
vim.opt.formatoptions = "tcq"

-- Set the visual indicator (color column)
vim.opt.colorcolumn = "121"

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.textwidth = 80
    vim.opt_local.colorcolumn = "81"
    vim.opt_local.formatoptions = "tcq"
  end,
})
