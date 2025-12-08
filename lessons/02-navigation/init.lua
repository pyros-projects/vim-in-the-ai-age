-- Lesson 02: Navigation
-- Config state after completing this lesson

-- Line numbers (lesson 01)
vim.opt.number = true
vim.opt.relativenumber = true

-- Tabs and indentation (lesson 01)
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Visual polish (lesson 01)
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

-- System clipboard (lesson 01)
vim.opt.clipboard = "unnamedplus"

-- Leader key (lesson 01)
vim.g.mapleader = " "

-- Escape from insert mode with jk (lesson 01)
vim.keymap.set("i", "jk", "<Esc>")

-- NEW in lesson 02: Navigation improvements
vim.opt.scrolloff = 8         -- Keep 8 lines visible above/below cursor
vim.opt.ignorecase = true     -- Case-insensitive search by default
vim.opt.smartcase = true      -- ...unless you use capital letters
