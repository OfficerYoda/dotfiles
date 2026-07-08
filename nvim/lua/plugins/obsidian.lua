return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  cond = vim.fn.getcwd():find(vim.fn.resolve(vim.fn.expand("~/Documents/vault")), 1, true) == 1,
  ft = "markdown",
  opts = {
    workspaces = {
      {
        name = "jedi-archives",
        path = vim.fn.expand("~/Documents/vault"),
      },
    },

    legacy_commands = false,
    notes_subdir = "/",
    new_notes_location = "inbox",
    completion = { min_chars = 0 },
    ui = { enable = false }, -- make render-markdown render everything
    footer = { enabled = false },
    picker = { name = "snacks.pick" },
    attachments = { folder = "attachments" },

    link = {
      style = "wiki",
      auto_update = true,
    },

    checkbox = {
      create_new = true, -- default
      order = { " ", "x", "-" },
    },
    daily_notes = {
      template = "daily-note.md",
      workdays_only = false,
    },

    templates = {
      folder = "templates",
      date_format = "YYYY-MM-DD",
      time_format = "HH:mm",

      customizations = {
        atomic = { notes_subdir = "notes" },
        moc = { notes_subdir = "notes" },
        person = { notes_subdir = "notes" },
      },
    },

    note_id_func = function(title)
      local prefix = os.date("%Y%m%d%H%M")
      if title ~= nil then
        local clean_title = title:gsub("[^%sa-zA-Z0-9ÄäÖöÜüß-]", ""):gsub("%s+", "-"):lower()
        return prefix .. "-" .. clean_title
      else
        return prefix .. "-" .. tostring(math.random(1000, 10000))
      end
    end,
  },

  keys = {
    -- 1. Note Creation & Templates
    { "<leader>on", "<cmd>Obsidian new<cr>", desc = "New Note" },
    { "<leader>ot", "<cmd>Obsidian new_from_template<cr>", desc = "New from Template" },
    { "<leader>oi", "<cmd>Obsidian template<cr>", desc = "Insert Template" },

    -- 2. Search & Navigation
    { "<leader>of", "<cmd>Obsidian quick_switch<cr>", desc = "Find Note File" },
    { "<leader>ob", "<cmd>Obsidian backlinks<cr>", desc = "Show Backlinks" },
    { "<leader>ol", "<cmd>Obsidian links<cr>", desc = "List All Links" },
    { "<leader>oc", "<cmd>Obsidian toc<cr>", desc = "Table of Contents" },

    -- 3. The "Zettelkasten" Link Follower
    { "<leader>ov", "<cmd>Obsidian follow_link vsplit<cr>", desc = "Follow Link (vsplit)" },

    -- 4. Visual Mode (Note the 'mode' key)
    { "<leader>ol", ":Obsidian link<cr>", mode = "v", desc = "Link Selection" },
    { "<leader>on", ":Obsidian link_new<cr>", mode = "v", desc = "Link to New Note" },
    { "<leader>oe", ":Obsidian extract_note<cr>", mode = "v", desc = "Extract to New Note" },

    -- 5. Daily Log & Productivity
    { "<leader>od", "<cmd>Obsidian today<cr>", desc = "Daily Note" },
    { "<leader>ox", "<cmd>Obsidian toggle_checkbox<cr>", desc = "Toggle Checkbox" },
    { "<leader>op", "<cmd>Obsidian paste_img<cr>", desc = "Paste Image" },

    -- 6. Maintenance
    { "<leader>or", "<cmd>Obsidian rename<cr>", desc = "Rename Note" },
  },
}
