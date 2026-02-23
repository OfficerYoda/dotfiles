return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    ft = { "markdown" },
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_auto_close = 0 -- Keep the preview open when switching
      vim.g.mkdp_combine_preview = 1 -- Use a single tab for all files
      vim.g.mkdp_combine_preview_auto_refresh = 1 -- Auto-update tab on buffer switch
    end,
  },
}
