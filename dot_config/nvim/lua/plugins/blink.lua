return {
  "saghen/blink.cmp",
  version = "*",
  opts = {
    -- 'default' for mappings: 'presets', 'super-tab' or 'enter'
    keymap = {
      preset = "enter",
      ["<Tab>"] = {
        function(cmp)
          if cmp.is_menu_visible() then
            return cmp.select_next()
          end
          return cmp.snippet_forward()
        end,
        "fallback",
      },
      ["<S-Tab>"] = {
        function(cmp)
          if cmp.is_menu_visible() then
            return cmp.select_prev()
          end
          return cmp.snippet_backward()
        end,
        "fallback",
      },
      -- Keep your other mappings
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },

    sources = {
      -- Add 'obsidian' to the list of default providers
      -- default = { "lsp", "path", "snippets", "buffer", "obsidian" },

      providers = {
        -- Configure the obsidian provider
        -- obsidian_blink = {
        --   name = "obsidian-blink",
        --   module = "blink.cmp.sources.lib",
        --   fallbacks = { "lsp" },
        --   -- Only show obsidian suggestions in your vault
        --   -- enabled = function()
        --   --   return vim.bo.filetype == "markdown" and require("obsidian").get_client():current_workspace() ~= nil
        --   -- end,
        -- },
      },
    },

    -- Optional: Better UI for suggestions
    completion = {
      list = { selection = { preselect = true, auto_insert = true } },
      -- menu = { border = "rounded" },
      -- documentation = { window = { border = "rounded" }, auto_show = true },
    },
  },
}
