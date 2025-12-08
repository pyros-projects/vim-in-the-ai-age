-- Neovim config after Lesson 04: Files and Buffers
-- Added: Window navigation keymaps

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Visual
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

-- System clipboard
vim.opt.clipboard = "unnamedplus"

-- Leader key
vim.g.mapleader = " "

-- Escape with jk
vim.keymap.set("i", "jk", "<Esc>")

-- Keep context when scrolling
vim.opt.scrolloff = 8

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- =============================================
-- NEW IN LESSON 04: Window navigation
-- =============================================
-- Move between splits with Ctrl + h/j/k/l
-- Instead of Ctrl-w h, Ctrl-w j, etc.
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- What you learned in Lesson 04:
-- Splits: :vs, :sp, Ctrl-w v, Ctrl-w s
-- Window nav: Ctrl-h/j/k/l (with these keymaps)
-- Window mgmt: Ctrl-w q, Ctrl-w o, Ctrl-w =
-- Buffers: :ls, :b name, :bn, :bp, :bd
-- Write all: :wa, Quit all: :qa
