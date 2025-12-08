-- vim-in-the-ai-age: Lesson 01 Config
-- This is your config after completing Lesson 01: Survival

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Tabs and indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Visual
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

-- System clipboard integration
vim.opt.clipboard = "unnamedplus"

-- Leader key (Space)
vim.g.mapleader = " "

-- Exit Insert mode with jk
vim.keymap.set("i", "jk", "<Esc>")

