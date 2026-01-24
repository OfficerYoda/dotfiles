return {
  "OfficerYoda/obsidian.nvim",
  version = "*",
  cond = vim.fn.getcwd() == vim.fn.resolve(vim.fn.expand("~/Documents/vault")),
  dependencies = {
    "nvim-lua/plenary.nvim",
    "saghen/blink.cmp",
  },
  opts = {
    workspaces = {
      {
        name = "jedi-archives",
        path = vim.fn.resolve(vim.fn.expand("~/Documents/vault")),
      },
    },

    -- 1. Completion Settings
    completion = {
      nvim_cmp = false, -- Disable nvim-cmp
      blink = true, -- Enable blink.cmp
      min_chars = 1,
    },

    -- 2. Link Formatting
    wiki_link_func = "prepend_note_id", -- e.g. [[202601111736-foo-bar|Foo Bar]]
    ui = { enable = false }, -- make render-markdown render everything
    footer = { enabled = false },
    picker = { name = "snacks.pick" },
    new_notes_location = "inbox",
    attachments = { img_folder = "attachments" },
    preferred_link_style = "wiki",
    checkbox = {
      create_new = true, -- default
      order = { " ", "x", "-" },
    },
    daily_notes = {
      template = "daily-note.md",
      workdays_only = false,
    },

    templates = {
      subdir = "templates",
      date_format = "%Y-%m-%d",
      alias_format = "Daily Note %Y-%m-%d",
      time_format = "%H:%M",
    },

    note_id_func = function(title)
      local prefix = os.date("%Y%m%d%H%M")
      if title ~= nil then
        local clean_title = title:gsub("[^%sa-zA-Z0-9ÄäÖöÜüß-]", ""):gsub("%s+", "-"):lower()
        return prefix .. "-" .. clean_title
      else
        return prefix .. "-" .. tostring(math.random(1000, 9999))
      end
    end,

    note_path_func = function(spec)
      local template_name = vim.fn.fnamemodify(spec.template, ":t")
      local default_folder = "inbox"

      -- Add or remove template mappings here
      local template_dirs = {
        ["atomic.md"] = "notes",
        ["person.md"] = "notes",
        ["moc.md"] = "notes",
      }

      local folder = template_dirs[template_name] or default_folder
      local path = folder == "" and tostring(spec.id) or (folder .. "/" .. spec.id)

      return path .. ".md"
    end,
  },
}
