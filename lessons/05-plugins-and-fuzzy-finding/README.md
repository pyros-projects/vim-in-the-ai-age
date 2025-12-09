# Lesson 05: Plugins and Fuzzy Finding

Your project has 4 files now. By lesson 10, you'll have 15. Typing `:e src/tsk/models.py` every time is going to get old fast.

Time to install plugins and make navigation instant.

## What You'll Learn

- Plugin management with lazy.nvim
- Fuzzy finding files with telescope
- File tree with nvim-tree
- Why plugins exist (and why you waited until now)

## Why We Waited

You could have installed 50 plugins on day one. Many people do. Then they have a config they don't understand, keybindings that conflict, and no idea what's built-in vs plugin.

You now know:
- Built-in window splits and buffers
- Native `:e`, `:ls`, `:b` commands
- How Vim actually works

Now plugins enhance what you already understand. Big difference.

## The Plugin Manager: lazy.nvim

Neovim doesn't have built-in plugin management. You need a plugin manager, and lazy.nvim is the best one:

- Lazy-loads plugins (fast startup)
- Simple configuration
- Automatic dependency management
- Great UI for managing plugins

### Install lazy.nvim

Open your config:

```bash
nvim ~/.config/nvim/init.lua
```

First, we need to bootstrap lazy.nvim. Add this near the top of your file, after your existing options but before any keymaps:

```lua
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
```

This does one thing: if lazy.nvim isn't installed, clone it. Then add it to Neovim's runtime path.

### Initialize lazy.nvim

Right after the bootstrap code, add:

```lua
require("lazy").setup({
    -- plugins go here
})
```

Save and quit (`:wq`), then reopen Neovim:

```bash
nvim
```

You should see lazy.nvim clone itself. When it's done, type `:Lazy` to see the plugin manager UI.

Press `q` to close it.

## Fuzzy Finding: telescope.nvim

Here's the problem: you want to open `models.py`. Your options right now:

1. `:e src/tsk/models.py` - too much typing
2. `:ls` then `:b mod` - works but clunky for files not in buffers
3. Navigate splits manually - doesn't scale

Here's the solution: type `<leader>ff`, type "mod", press enter. Done.

That's telescope.

### Install telescope

Update your lazy.setup to include telescope:

```lua
require("lazy").setup({
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
        },
    },
})
```

Let's break this down:

- `branch = "0.1.x"` - use stable branch
- `dependencies` - telescope needs plenary.nvim (utility library)
- `keys` - lazy-load: plugin loads only when you use these keybindings

### Install ripgrep (required for live_grep)

Telescope's `live_grep` uses ripgrep under the hood. Install it:

```bash
# Ubuntu/Debian
sudo apt install ripgrep

# macOS
brew install ripgrep

# Arch
sudo pacman -S ripgrep

# Windows (WSL)
sudo apt install ripgrep
```

### Try telescope

Save your config (`:w`), quit (`:q`), and reopen:

```bash
nvim ~/.config/nvim/init.lua
```

You'll see lazy.nvim install telescope and plenary.

Now try it:

1. `<leader>ff` - opens file finder
2. Type "init" - see it filter
3. Press `Enter` to open, or `Esc` to cancel

Navigate your tsk project:

```bash
cd ~/projects/tsk
nvim .
```

Try these:

| Command | What It Does |
|---------|--------------|
| `<leader>ff` | Find files - fuzzy search all files |
| `<leader>fg` | Live grep - search file contents |
| `<leader>fb` | Buffers - switch between open files |
| `<leader>fh` | Help tags - search Neovim documentation |

### The Telescope Workflow

1. **Finding files:** `<leader>ff`, type partial name, enter
2. **Searching code:** `<leader>fg`, type pattern, navigate results
3. **Switching buffers:** `<leader>fb`, type partial name, enter

Inside telescope:

| Key | Action |
|-----|--------|
| `Ctrl-j` / `Ctrl-k` | Move up/down in results |
| `Enter` | Open selected file |
| `Ctrl-v` | Open in vertical split |
| `Ctrl-x` | Open in horizontal split |
| `Esc` | Close telescope |

### Try Live Grep

In your tsk project, search for "Status":

1. `<leader>fg`
2. Type "Status"
3. See every file containing "Status"
4. `Ctrl-j/k` to navigate results
5. `Enter` to jump to that location

You just searched your entire codebase in under a second.

## File Tree: nvim-tree

Sometimes you want to see the project structure visually. nvim-tree gives you a file explorer sidebar.

Add it to your lazy.setup:

```lua
require("lazy").setup({
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
        },
    },

    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "File explorer" },
        },
        config = function()
            require("nvim-tree").setup()
        end,
    },
})
```

Save, quit, reopen. Lazy installs nvim-tree.

Now:

1. `<leader>e` - toggle file tree
2. `j/k` to navigate
3. `Enter` to open file
4. `a` to create new file
5. `d` to delete file
6. `r` to rename
7. `<leader>e` again to close

### When to Use What

| Need | Use |
|------|-----|
| Find file by name | `<leader>ff` (telescope) |
| Search code content | `<leader>fg` (telescope) |
| Switch open files | `<leader>fb` (telescope) |
| See project structure | `<leader>e` (nvim-tree) |
| Create/delete files | `<leader>e` (nvim-tree) |

Telescope is for jumping. nvim-tree is for exploring and file operations.

## Add a Theme

Your Neovim is functional but ugly. Let's fix that.

Add catppuccin to your plugins:

```lua
require("lazy").setup({
    -- ... telescope and nvim-tree ...

    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("catppuccin-mocha")
        end,
    },
})
```

- `priority = 1000` - load this before other plugins (themes need to load first)
- `config` function runs after the plugin loads

Save, quit, reopen. You now have a proper theme.

### Theme Variants

Catppuccin has four flavors:

- `catppuccin-latte` - light theme
- `catppuccin-frappe` - dark-ish
- `catppuccin-macchiato` - darker
- `catppuccin-mocha` - darkest (what we're using)

Change the `colorscheme` line if you prefer lighter.

## Your Complete Config So Far

Here's what your `init.lua` should look like:

```lua
-- Options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.clipboard = "unnamedplus"
vim.opt.scrolloff = 8
vim.opt.updatetime = 50

vim.g.mapleader = " "

-- Escape insert mode with jk
vim.keymap.set("i", "jk", "<Esc>")

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
    -- Fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
        },
    },

    -- File tree
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "File explorer" },
        },
        config = function()
            require("nvim-tree").setup()
        end,
    },

    -- Theme
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("catppuccin-mocha")
        end,
    },
})
```

## Practice: Navigate Your Project

Open your tsk project:

```bash
cd ~/projects/tsk
nvim .
```

Do these exercises:

1. **Find main.py:** `<leader>ff`, type "main", enter
2. **Find "TaskStore":** `<leader>fg`, type "TaskStore", see results
3. **Open models.py:** `<leader>ff`, type "mod", enter
4. **Switch back to main.py:** `<leader>fb`, type "main", enter
5. **View project structure:** `<leader>e`, navigate around, `<leader>e` to close
6. **Create a test file:** `<leader>e`, navigate to project root, press `a`, type `tests/test_models.py`, enter

That last one created your tests directory and file. Open it with telescope: `<leader>ff` "test".

## Quick Reference: New Keybindings

| Command | Action |
|---------|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep (search contents) |
| `<leader>fb` | Switch buffers |
| `<leader>fh` | Search help |
| `<leader>e` | Toggle file tree |

### Inside Telescope

| Key | Action |
|-----|--------|
| `Ctrl-j` / `Ctrl-k` | Navigate results |
| `Enter` | Open file |
| `Ctrl-v` | Open in vertical split |
| `Ctrl-x` | Open in horizontal split |
| `Esc` | Close |

### Inside nvim-tree

| Key | Action |
|-----|--------|
| `j` / `k` | Navigate |
| `Enter` | Open file/expand folder |
| `a` | Create file |
| `d` | Delete file |
| `r` | Rename |
| `q` | Close tree |

## Checkpoint

You should now be able to:

1. **Manage plugins** - `:Lazy` opens the plugin manager
2. **Find files instantly** - `<leader>ff` + partial name
3. **Search code** - `<leader>fg` + pattern
4. **Switch buffers** - `<leader>fb`
5. **View project structure** - `<leader>e`
6. **Create/rename/delete files** - from nvim-tree

Your config: ~80 lines and growing.

## Common Issues

**"Telescope not found"**

Did you save the config and restart Neovim? Lazy needs to install the plugin.

**"No results in find_files"**

Make sure you opened Neovim in your project directory (`nvim .` from project root), or that your current working directory contains files.

**"live_grep doesn't work"**

Install ripgrep. It's required. Check with `rg --version` in terminal.

**"Icons look weird in nvim-tree"**

You need a Nerd Font. Install one from https://www.nerdfonts.com/ and set it as your terminal font. Or ignore the weird characters - it still works.

**"Plugin installation failed"**

Run `:Lazy` and press `I` to retry installing. Check your internet connection.

**"I added a plugin but nothing happened"**

Save the config file (`:w`), quit Neovim (`:q`), reopen. Lazy installs on startup.

## Key Takeaways

1. **Plugins extend, not replace** — You understand splits, buffers, and native navigation. Plugins make them faster, not different.

2. **lazy.nvim is the standard** — Lazy-loading means fast startup. The `keys` table means plugins load only when used.

3. **Telescope is your jump command** — `<leader>ff` is faster than any file tree for known targets. `<leader>fg` searches content instantly.

4. **nvim-tree is for exploring** — When you need to see structure or create files, the tree shines. For jumping, use telescope.

5. **Everything is a keybinding** — Notice we didn't add menu buttons or mouse interactions. `<leader>ff`, `<leader>e`, done.

6. **Themes are one line** — Don't spend hours on themes. Pick one that works, move on. You can change it in 30 seconds.

## Want More Plugins?

We installed three plugins. The ecosystem has thousands.

**See [Plugin Ecosystem Guide](../../docs/plugin-ecosystem.md)** for:
- Pre-built Neovim distributions (LazyVim, AstroNvim, etc.)
- Plugins you can add now (post-Lesson 05)
- Plugins that need LSP (post-Lesson 06)
- The "awesome-neovim" list

Don't install everything at once. Feel a pain point, find a plugin, try it for a week. Keep what you use.

## The Insight

You just transformed Neovim from "editor with weird keybindings" to "editor that navigates faster than any IDE."

Think about what you can do now:
- Jump to any file in milliseconds
- Search entire codebases instantly
- Switch between files without touching the mouse
- See project structure when you need it

This is why Vim users seem unreasonably fast. It's not superhuman memory. It's telescope + muscle memory + never leaving the keyboard.

Next lesson adds LSP — autocomplete, go-to-definition, rename, all the "real IDE" features. The speed compounds.

---

[Next: Lesson 06 - LSP and Completion →](../06-lsp-and-completion/)
