-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- --- Line Navigation ---
-- Remap 'j' and 'k' to move by display lines, not physical lines.
map("n", "j", "gj", { desc = "Move down by display line" })
map("n", "k", "gk", { desc = "Move up by display line" })
map("v", "j", "gj", { desc = "Move down by display line in visual mode" })
map("v", "k", "gk", { desc = "Move up by display line in visual mode" })

-- Remap 'G' and 'gg' to move to end/start of line as well.
map("n", "G", "G$", { desc = "Go to last line and end of line" })
map("n", "gg", "gg0", { desc = "Go to first line and start of line" })
map("v", "G", "G$", { desc = "Go to last line and end of line in visual mode" })
map("v", "gg", "gg0", { desc = "Go to first line and start of line in visual mode" })

-- Move to start/end of visual line
-- map("n", "0", "g^", { desc = "Move to beginning of visual line" })
-- map("n", "$", "g$", { desc = "Move to end of visual line" })
-- map("x", "0", "g^", { desc = "Extend selection to beginning of visual line" })
-- map("x", "$", "g$", { desc = "Extend selection to end of visual line" })

-- --- Smart Line Join ---
-- Join lines (J) and keep cursor position
map("n", "J", "mjJ`j", { desc = "Join line and restore cursor position" })

-- --- Deletion to Blackhole Register ---
-- Delete/cut without overwriting the default clipboard/register
-- <Leader> is mapped to the leader key, which is \ by default in Neovim/Vim
map({ "n", "x" }, "<Leader>d", '"_d', { desc = "Delete to blackhole register" })
-- '<Leader>x is already bound to "diagnostics/quickfix', use '<Leader>dl' instead
-- map({ "n", "x" }, "<Leader>x", '"_x', { desc = "Delete char to blackhole register" })
map({ "n", "x" }, "<Leader>D", '"_D', { desc = "Delete to end of line to blackhole register" })

-- --- Centered Scrolling ---
-- Keep the cursor centered when scrolling with Ctrl-d/u
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll half-page down (and center)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll half-page up (and center)" })

-- --- Visual Paste to Blackhole Register ---
-- Paste selected text without affecting the default clipboard/register
-- Note: 'xnoremap' includes both visual and select mode, which is handled by mode 'x' or table {'v', 's'}
map("x", "<Leader>p", '"_dP', { desc = "Paste visual selection to blackhole register (lowercase)" })
map("x", "<Leader>P", '"_dP', { desc = "Paste visual selection to blackhole register (uppercase)" })

-- --- Alternative Ways to Enter Normal Mode ---
-- 'i': Insert mode; 't': Terminal-Job mode; 's': Select mode
-- local modes = { "i", "t", "s" }
--
-- Remap 'jk' and 'kj' to <Esc> in the specified modes
-- map(modes, "jk", "<Esc>", { desc = "Exit Mode (jk)" })
-- map(modes, "kj", "<Esc>", { desc = "Exit Mode (kj)" })

-- Enables moving in the terminal in normal mode
map("t", "<C-ä>", [[<C-\><C-n>]], { noremap = true })

-- Remap <C-c> to work exactly like <Esc>
map("i", "<C-c>", "<Esc>", { noremap = true, silent = true })

-- 1. Note Creation & Templates
map("n", "<leader>on", "<cmd>Obsidian new<cr>", { desc = "New Note" })
map("n", "<leader>ot", "<cmd>Obsidian new_from_template<cr>", { desc = "New from Template" })
map("n", "<leader>oi", "<cmd>Obsidian template<cr>", { desc = "Insert Template" })

-- 2. Search & Navigation (The "Knowledge Graph")
map("n", "<leader>of", "<cmd>Obsidian quick_switch<cr>", { desc = "Find Note File" })
map("n", "<leader>ob", "<cmd>Obsidian backlinks<cr>", { desc = "Show Backlinks" })
map("n", "<leader>ol", "<cmd>Obsidian links<cr>", { desc = "List All Links" })
map("n", "<leader>oc", "<cmd>Obsidian toc<cr>", { desc = "Table of Contents" })

-- 3. The "Zettelkasten" Link Follower
map("n", "<leader>ov", "<cmd>Obsidian follow_link vsplit<cr>", { desc = "Follow Link (vsplit)" })

-- 4. Visual Mode (Working with text)
-- 'Link' an existing concept or 'Extract' a new one
map("v", "<leader>ol", ":Obsidian link<cr>", { desc = "Link Selection" })
map("v", "<leader>on", ":Obsidian link_new<cr>", { desc = "Link to New Note" })
map("v", "<leader>oe", ":Obsidian extract_note<cr>", { desc = "Extract to New Note" })

-- 5. Daily Log & Productivity
map("n", "<leader>od", "<cmd>Obsidian today<cr>", { desc = "Daily Note" })
map("n", "<leader>ox", "<cmd>Obsidian toggle_checkbox<cr>", { desc = "Toggle Checkbox" })
map("n", "<leader>op", "<cmd>Obsidian paste_img<cr>", { desc = "Paste Image" })

-- 6. Maintenance
map("n", "<leader>or", "<cmd>Obsidian rename<cr>", { desc = "Rename Note" })

-- Logical Symbols
map("i", "]xor", "⊕", { desc = "XOR Symbol" })
map("i", "]and", "∧", { desc = "AND Symbol" })
map("i", "]or", "∨", { desc = "OR Symbol" })
map("i", "]not", "¬", { desc = "NOT Symbol" })
map("i", "]imp", "→", { desc = "Implikation" })
map("i", "]>", "→", { desc = "Implikation" })
map("i", "]|>", "↦", { desc = "Long rightwards arrow" })
map("i", "]eq", "↔", { desc = "Äquivalenz" })
map("i", "]<", "↔", { desc = "Äquivalenz" })
map("i", "]all", "∀", { desc = "Allquantor" })
map("i", "]atl", "∃", { desc = "Existenzquantor" })
map("i", "]one", "∃", { desc = "Existenzquantor" })
map("i", "]in", "∈", { desc = "Elementoperator" })
map("i", "]nin", "∉", { desc = "Not element of" })
map("i", "]circ", "∘", { desc = "Circled times (Kreisel)" })

map("i", "]N", "ℕ", { desc = "Set of natural numbers" })
map("i", "]Z", "ℤ", { desc = "Set of integers" })
map("i", "]Q", "ℚ", { desc = "Set of rational numbers" })
map("i", "]R", "ℝ", { desc = "Set of real numbers" })
map("i", "]C", "ℂ", { desc = "Set of complex numbers" })
map("i", "]inf", "∞", { desc = "Infinity" })
map("i", "]cdot", "⋅", { desc = "Dot operator" })
map("i", "]times", "×", { desc = "Multiplication sign" })
map("i", "]div", "÷", { desc = "Division sign" })
map("i", "]pm", "±", { desc = "Plus-minus" })
map("i", "]leq", "≤", { desc = "Less than or equal to" })
map("i", "]geq", "≥", { desc = "Greater than or equal to" })
map("i", "]neq", "≠", { desc = "Not equal to" })
map("i", "]!=", "≠", { desc = "Not equal to" })
map("i", "]app", "≈", { desc = "Approximately equal" })
map("i", "~=", "≈", { desc = "Approximately equal" })
map("i", "]cor", "≙", { desc = "Corresponds to" })
map("i", "^=", "≙", { desc = "Corresponds to" })
map("i", "]check", "✓", { desc = "Checkmark" })
map("i", "]cup", "∪", { desc = "Union" })
map("i", "]cap", "∩", { desc = "Intersection" })
map("i", "]sub", "⊂", { desc = "Subset" })
map("i", "]sup", "⊃", { desc = "Superset" })
map("i", "]nsub", "⊄", { desc = "Not a subset" })
map("i", "]nsup", "⊅", { desc = "Not a superset" })
map("i", "]subeq", "⊆", { desc = "Subset or equal" })
map("i", "]supeq", "⊇", { desc = "Superset or equal" })
map("i", "]emp", "∅", { desc = "Empty set" })
map("i", "]del", "∆", { desc = "Delta symbol" })

-- Superscript numbers
map("i", "^0", "⁰", { desc = "Superscript 0" })
map("i", "^1", "¹", { desc = "Superscript 1" })
map("i", "^2", "²", { desc = "Superscript 2" })
map("i", "^3", "³", { desc = "Superscript 3" })
map("i", "^4", "⁴", { desc = "Superscript 4" })
map("i", "^5", "⁵", { desc = "Superscript 5" })
map("i", "^6", "⁶", { desc = "Superscript 6" })
map("i", "^7", "⁷", { desc = "Superscript 7" })
map("i", "^8", "⁸", { desc = "Superscript 8" })
map("i", "^9", "⁹", { desc = "Superscript 9" })

-- Superscript symbols
map("i", "^+", "⁺", { desc = "Superscript +" })
map("i", "^-", "⁻", { desc = "Superscript -" })
map("i", "^(", "⁽", { desc = "Superscript (" })
map("i", "^ˆ)", "⁾", { desc = "Superscript )" })

-- Superscript letters
map("i", "^n", "ⁿ", { desc = "Superscript n" })
map("i", "^i", "ⁱ", { desc = "Superscript i" })

-- Subscript numbers
map("i", "_0", "₀", { desc = "Subscript 0" })
map("i", "_1", "₁", { desc = "Subscript 1" })
map("i", "_2", "₂", { desc = "Subscript 2" })
map("i", "_3", "₃", { desc = "Subscript 3" })
map("i", "_4", "₄", { desc = "Subscript 4" })
map("i", "_5", "₅", { desc = "Subscript 5" })
map("i", "_6", "₆", { desc = "Subscript 6" })
map("i", "_7", "₇", { desc = "Subscript 7" })
map("i", "_8", "₈", { desc = "Subscript 8" })
map("i", "_9", "₉", { desc = "Subscript 9" })
map("i", "_10", "₁₀", { desc = "Subscript 10" })

-- Subscript symbols
map("i", "_+", "₊", { desc = "Subscript +" })
map("i", "_-", "₋", { desc = "Subscript -" })
map("i", "_(", "₍", { desc = "Subscript (" })
map("i", "_)", "₎", { desc = "Subscript )" })

-- Subscript letters (common)
-- map("i", "_a", "ₐ", { desc = "Subscript a" })
-- map("i", "_e", "ₑ", { desc = "Subscript e" })
-- map("i", "_o", "ₒ", { desc = "Subscript o" })
map("i", "_x", "ₓ", { desc = "Subscript x" })

map("n", "<leader>rj", function()
  Snacks.terminal.open("jr " .. vim.fn.expand("%"), {
    win = { position = "bottom" },
    desc = "Run Java",
  })
end, { desc = "Run Java" })

map("n", "<leader>rp", function()
  Snacks.terminal.open("swipl -s " .. vim.fn.expand("%"), {
    win = { position = "bottom" },
    desc = "Run Prolog",
  })
end, { desc = "Run Prolog" })

map("n", "<leader>rg", function()
  Snacks.terminal.open("go run " .. vim.fn.expand("%") .. " && read", {
    win = { position = "bottom" },
    desc = "Run Go",
  })
end, { desc = "Run Go" })

-- i have the high ground
-- hello down here
