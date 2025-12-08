-- vim-in-the-ai-age: Minimal Config
-- The foundation. ~15 lines that make Neovim usable.
-- Corresponds to Lesson 01: Survival

-- Line numbers (relative for easy jumping with 5j, 3k, etc.)
vim.opt.number = true
vim.opt.relativenumber = true

-- Tabs: 4 spaces, no actual tab characters
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Visual polish
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

-- System clipboard (yank/paste works with system)
vim.opt.clipboard = "unnamedplus"

-- Leader key: Space
-- All custom keybindings will start with Space
vim.g.mapleader = " "

-- Exit Insert mode with jk (faster than reaching for Escape)
vim.keymap.set("i", "jk", "<Esc>")

