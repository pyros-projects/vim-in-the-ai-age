-- Neovim config after Lesson 03: Editing Grammar
-- No new additions - the grammar is built into Vim!
-- This file shows your config state at this point.

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

-- That's it. The editing grammar (d, c, y, text objects)
-- is built into Vim. No config needed.
--
-- What you learned in Lesson 03:
-- Operators: d (delete), c (change), y (yank)
-- Text objects: iw, aw, i", a", i(, i{, etc.
-- The dot command: . (repeat last change)
-- Visual modes: v, V, Ctrl-v
--
-- These are core Vim - always available, zero setup.
