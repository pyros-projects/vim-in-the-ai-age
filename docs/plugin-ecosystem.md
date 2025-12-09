# Neovim Plugin Ecosystem

A curated guide to plugins worth exploring. Organized by complexity and when you're ready for them.

## Pre-Built Distributions

Before building your own config, you should know these exist. They're fully configured Neovim setups that "just work."

### Why Use a Distribution?

**Pros:**
- Zero config to start
- Curated plugin selections
- Sensible defaults
- Community-maintained
- Great for learning what's possible

**Cons:**
- You don't understand your own config
- Harder to customize
- Updates can break things
- Bloat you don't need

**Our recommendation:** Build your own config (what this tutorial teaches), but study distributions to learn what plugins exist and how they're configured.

### The Big Three

#### LazyVim
**The most popular modern distribution.**

- Website: https://www.lazyvim.org/
- GitHub: https://github.com/LazyVim/LazyVim
- Philosophy: "Lazy" loading, modular, easy to extend

LazyVim is built on lazy.nvim (same plugin manager we use). It's modular - you can enable/disable features. Great source of config patterns.

**Learn from it:**
- Browse their plugin specs: https://github.com/LazyVim/LazyVim/tree/main/lua/lazyvim/plugins
- See how they configure LSP, telescope, treesitter
- Steal keybinding ideas

#### AstroNvim
**Batteries-included but customizable.**

- Website: https://astronvim.com/
- GitHub: https://github.com/AstroNvim/AstroNvim
- Philosophy: Full IDE experience out of the box

More opinionated than LazyVim. Good if you want something that works immediately.

#### NvChad
**Beautiful defaults, performance-focused.**

- Website: https://nvchad.com/
- GitHub: https://github.com/NvChad/NvChad
- Philosophy: Fast, beautiful, minimal bloat

Known for its theme system and clean UI. Good design inspiration.

### Mini Distributions

#### kickstart.nvim
**The official "learn by example" config.**

- GitHub: https://github.com/nvim-lua/kickstart.nvim
- Philosophy: Single-file config, heavily commented

**This is gold for learning.** It's a single `init.lua` with detailed comments explaining every line. Read this after finishing our tutorial.

#### mini.nvim
**One developer's complete toolkit.**

- GitHub: https://github.com/echasnovski/mini.nvim
- Philosophy: Minimal, no dependencies, one author

A collection of ~30 small plugins that can replace bigger alternatives. Each module is independent. Great for "I want X but don't want a heavy plugin."

---

## Plugins You Can Use Now (Post-Lesson 05)

These work without LSP. Install them, experiment, see what clicks.

### Navigation & Movement

#### flash.nvim
**Jump anywhere on screen in 2-3 keystrokes.**

```lua
{
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    },
}
```

Press `s`, type a character, see labels appear, press the label. Faster than search for short jumps.

#### leap.nvim
**Alternative to flash with different philosophy.**

```lua
{
    "ggandor/leap.nvim",
    config = function()
        require("leap").add_default_mappings()
    end,
}
```

Similar concept, different feel. Try both, pick one.

#### harpoon
**Bookmark files you jump to constantly.**

```lua
{
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()

        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
        vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
        vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
    end,
}
```

Mark 4-5 files you're constantly switching between. `<leader>1` through `<leader>4` to jump instantly. Faster than telescope for your "hot" files.

### UI Enhancements

#### which-key.nvim
**Shows available keybindings as you type.**

```lua
{
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
}
```

Press `<leader>` and wait - a popup shows all available bindings. Essential for learning your own config.

#### lualine.nvim
**Better status line.**

```lua
{
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        options = {
            theme = "catppuccin",
        },
    },
}
```

Shows mode, file, git branch, diagnostics. The status line you see in screenshots.

#### bufferline.nvim
**Tabs for buffers.**

```lua
{
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
}
```

Adds a tab bar showing open buffers. Some people love it, some prefer telescope. Try it.

#### indent-blankline.nvim
**Visual indentation guides.**

```lua
{
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
}
```

Shows vertical lines at indentation levels. Helpful in Python where indentation is syntax.

#### todo-comments.nvim
**Highlight TODO, FIXME, NOTE comments.**

```lua
{
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
}
```

TODOs become colored and searchable. `:TodoTelescope` shows all TODOs in project.

### Editing Enhancements

#### nvim-autopairs
**Auto-close brackets, quotes, etc.**

```lua
{
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
}
```

Type `(`, get `()` with cursor inside. Simple but useful.

#### nvim-surround
**Add/change/delete surrounding characters.**

```lua
{
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
}
```

- `ysiw"` - surround word with quotes
- `cs"'` - change surrounding `"` to `'`
- `ds"` - delete surrounding quotes

This is a power-user favorite. The Vim grammar extended.

#### Comment.nvim
**Toggle comments easily.**

```lua
{
    "numToStr/Comment.nvim",
    opts = {},
}
```

`gcc` - toggle comment on line
`gc` in visual mode - toggle comment on selection

### Git Integration

#### gitsigns.nvim
**Git status in the sign column.**

```lua
{
    "lewis6991/gitsigns.nvim",
    opts = {
        on_attach = function(bufnr)
            local gs = require("gitsigns")
            vim.keymap.set("n", "]c", gs.next_hunk, { buffer = bufnr })
            vim.keymap.set("n", "[c", gs.prev_hunk, { buffer = bufnr })
            vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { buffer = bufnr })
            vim.keymap.set("n", "<leader>hr", gs.reset_hunk, { buffer = bufnr })
        end,
    },
}
```

Shows added/modified/deleted lines. Jump between changes with `]c`/`[c`. Essential for reviewing AI edits.

**Note:** We cover this in Lesson 09, but you can add it earlier.

#### lazygit.nvim
**Full git UI inside Neovim.**

```lua
{
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
}
```

Requires lazygit installed (`brew install lazygit` / `apt install lazygit`). Opens a full terminal UI for git operations.

### File Management

#### oil.nvim
**Edit your filesystem like a buffer.**

```lua
{
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    keys = {
        { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
    },
}
```

Opens directories as editable buffers. Rename files by editing text. Delete by deleting lines. Weird but powerful.

#### neo-tree.nvim
**Alternative to nvim-tree.**

Some prefer neo-tree's features. Try both, pick one.

---

## Plugins That Need LSP (Post-Lesson 06)

Wait until you have LSP configured before adding these.

### Code Intelligence

#### trouble.nvim
**Better diagnostics list.**

```lua
{
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    keys = {
        { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics" },
    },
}
```

Shows all errors/warnings in a navigable list. Better than the quickfix list.

#### aerial.nvim
**Code outline/symbol browser.**

```lua
{
    "stevearc/aerial.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    opts = {},
    keys = {
        { "<leader>o", "<cmd>AerialToggle!<cr>", desc = "Outline" },
    },
}
```

Shows functions/classes/methods in a sidebar. Click to jump.

#### lspsaga.nvim
**Enhanced LSP UI.**

Better hover docs, code actions, rename UI. Makes LSP feel more polished.

### Debugging

#### nvim-dap
**Debug Adapter Protocol client.**

Full debugging in Neovim - breakpoints, stepping, variable inspection. Complex to set up but powerful.

Related plugins:
- `nvim-dap-ui` - UI for dap
- `nvim-dap-python` - Python-specific config

### Testing

#### neotest
**Test runner framework.**

```lua
{
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/neotest-python",  -- for Python
    },
}
```

Run tests from Neovim, see results inline. Per-language adapters.

---

## The "Awesome Neovim" List

For everything else: https://github.com/rockerBOO/awesome-neovim

Categorized list of Neovim plugins. When you want something specific, search here first.

---

## Philosophy: Less Is More

A warning before you install 50 plugins:

1. **Each plugin is code you don't control** - Updates can break things
2. **Plugins conflict** - Two plugins binding the same key = debugging
3. **Startup time adds up** - 50 plugins = slow Neovim
4. **You forget what's built-in** - Maybe Neovim already does that

**The approach:**
1. Feel a real pain point
2. Search for a plugin that solves it
3. Try it for a week
4. Keep it if you use it, delete it if you don't

Don't install plugins because they look cool. Install them because you need them.

---

## Next Steps

After Lesson 05:
- [ ] Try which-key.nvim (helps you learn)
- [ ] Try nvim-surround (extends Vim grammar)
- [ ] Try gitsigns (essential for AI workflow)
- [ ] Browse LazyVim's plugin specs for ideas

After Lesson 06 (LSP):
- [ ] Try trouble.nvim
- [ ] Try aerial.nvim
- [ ] Consider neotest if you write tests

After Lesson 08 (Claude Code):
- [ ] Ensure gitsigns is configured
- [ ] Consider harpoon for hot files

---

*This document will grow as we discover more plugins worth recommending.*
