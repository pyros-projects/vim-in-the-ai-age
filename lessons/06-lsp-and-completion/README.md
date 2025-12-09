# Lesson 06: LSP and Completion

You can find files instantly. You can search code. But when you type `store.` and nothing happens... that's when you miss your IDE.

Time to fix that.

## What You'll Learn

- What LSP actually is (and why it matters)
- Mason for installing language servers
- Autocompletion with nvim-cmp
- Go-to-definition, hover docs, rename
- Treesitter for better syntax highlighting
- The keybindings that make this useful

## The Problem

Open your tsk project:

```bash
cd ~/projects/tsk
nvim src/tsk/main.py
```

Try these:

1. Type `store.` — nothing suggests methods
2. Put cursor on `TaskStore` — no way to jump to its definition
3. Hover over a function — no documentation appears
4. Want to rename `task_id` everywhere — have to do it manually

This is what "real IDE features" means. And LSP gives them to you.

## What Is LSP?

**Language Server Protocol** is a standard that separates "understanding code" from "editing code."

Before LSP:
- Every editor reimplemented Python intelligence
- VS Code's Python support ≠ Vim's Python support
- Quality varied wildly

After LSP:
- One Python language server (pyright, pylsp, etc.)
- Any editor can use it
- Same intelligence everywhere

```
┌─────────────┐         ┌──────────────────┐
│   Neovim    │ ←LSP→   │  pyright         │
│  (editor)   │         │  (understands    │
│             │         │   Python)        │
└─────────────┘         └──────────────────┘
```

Neovim asks pyright: "What methods does TaskStore have?"
Pyright answers: "add, complete, delete, clear_completed, list_all"
Neovim shows you the list.

That's it. Neovim handles editing, pyright handles understanding.

## The Setup

We need four things:

1. **mason.nvim** — Installs language servers
2. **mason-lspconfig.nvim** — Connects mason to Neovim's LSP
3. **nvim-lspconfig** — Configures the language servers
4. **nvim-cmp** — Autocompletion engine

Plus **treesitter** for better syntax highlighting (bonus, but worth it).

### Install the Plugins

Open your config:

```bash
nvim ~/.config/nvim/init.lua
```

Add these to your `lazy.setup({})`:

```lua
    -- LSP
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = { "pyright" },
            })

            local lspconfig = require("lspconfig")
            lspconfig.pyright.setup({})

            -- Keybindings when LSP attaches to a buffer
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local opts = { buffer = args.buf }
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
                    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
                end,
            })
        end,
    },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                }),
            })
        end,
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "python", "lua", "json", "markdown", "toml", "yaml" },
                auto_install = true,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },
```

Save, quit, reopen Neovim. You'll see:

1. Lazy installing new plugins
2. Mason installing pyright (might take a minute)
3. Treesitter installing parsers

Wait for it all to finish. Check with `:Mason` — you should see pyright installed.

## Test It: Autocompletion

Open your project:

```bash
cd ~/projects/tsk
nvim src/tsk/main.py
```

Find the `add` function. Inside it, after `store = TaskStore()`, start a new line and type:

```
store.
```

**A menu appears.** You see `add`, `complete`, `delete`, `get`, `list_all`, etc.

Use `Tab` to move down the list, `Shift-Tab` to move up, `Enter` to select.

That's autocompletion. It knows what methods exist because pyright analyzed your code.

### Completion Sources

The menu shows items from different sources:

- **LSP** — Methods, functions, variables from pyright
- **Buffer** — Words from the current file
- **Path** — File paths when you type `./` or `~/`

You'll see icons or labels indicating the source.

## Test It: Go to Definition

Put your cursor on `TaskStore` (the class name in the import or usage).

Press `gd`.

**You jump to the definition in models.py.** No telescope, no searching, just instant navigation.

Press `Ctrl-o` to jump back to where you were.

This is the killer feature. See a function call? `gd` to see what it does. Understand it, `Ctrl-o` back.

### Navigation Stack

Neovim maintains a "jump list" — everywhere you've jumped from.

| Key | Action |
|-----|--------|
| `Ctrl-o` | Jump back (older position) |
| `Ctrl-i` | Jump forward (newer position) |

You can chain these. `gd` into a definition, `gd` into another, then `Ctrl-o` `Ctrl-o` to get back.

## Test It: Hover Documentation

Put cursor on any function name — say, `store.add`.

Press `K`.

A floating window shows the function signature and docstring. This is hover documentation.

Press `K` again (or any movement key) to close it.

## Test It: Find References

Put cursor on `task_id` (the parameter in the `done` function).

Press `gr`.

Telescope opens showing every place `task_id` is used. Select one to jump there.

This answers: "Where is this variable used?"

## Test It: Rename

This is where it gets powerful.

Put cursor on `task_id` in the `done` function.

Press `<leader>rn`.

Type a new name: `id` (or whatever).

Press `Enter`.

**Every usage of that variable is renamed.** In the function signature, in the body, everywhere it's used in that scope.

This is refactoring. The LSP understands scope — it won't rename unrelated variables with the same name.

Undo with `u` if you want the original name back.

## Test It: Diagnostics

Let's create an error. In main.py, type:

```python
x = undefined_variable
```

Save the file (`:w`).

You'll see:
- A sign in the left gutter (probably a red icon)
- The line might be underlined
- `]d` jumps to the next diagnostic

Press `]d` to jump to the error. Press `<leader>d` to see the full message in a floating window.

Delete the bad line and save. The error disappears.

### Diagnostic Navigation

| Key | Action |
|-----|--------|
| `]d` | Next diagnostic |
| `[d` | Previous diagnostic |
| `<leader>d` | Show diagnostic float |

## Test It: Code Actions

Some diagnostics have fixes. Put cursor on an error and press `<leader>ca`.

If fixes exist, a menu appears. Select one to apply it.

Code actions also include things like:
- Organize imports
- Extract to variable
- Add type annotation

Not all languages support all actions. Python with pyright has a decent set.

## Treesitter: Better Highlighting

You might not notice it immediately, but your syntax highlighting is now better.

Treesitter parses your code into a syntax tree and highlights based on structure, not regex patterns.

Before treesitter:
- `def` is highlighted as a keyword
- Function names might not be highlighted

After treesitter:
- `def` is a keyword
- Function name is highlighted as a function
- Parameters are highlighted as parameters
- Even nested structures are correctly colored

It's subtle but makes code more readable.

### Treesitter Text Objects (Bonus)

You can add treesitter-powered text objects:

```lua
-- Add this plugin to lazy.setup if you want it
{
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
        require("nvim-treesitter.configs").setup({
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                    },
                },
            },
        })
    end,
}
```

Now `daf` deletes a function, `cif` changes the function body. The grammar extends to code structure.

This is optional — add it when you feel the need.

## Your Complete Config

After this lesson, your `init.lua` is around 150-180 lines. Here's the full thing:

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

    -- LSP
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = { "pyright" },
            })

            local lspconfig = require("lspconfig")
            lspconfig.pyright.setup({})

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local opts = { buffer = args.buf }
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
                    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
                end,
            })
        end,
    },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                }),
            })
        end,
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "python", "lua", "json", "markdown", "toml", "yaml" },
                auto_install = true,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },
})
```

## Quick Reference: LSP Keybindings

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Find references |
| `gi` | Go to implementation |
| `K` | Hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>d` | Show diagnostic |
| `]d` | Next diagnostic |
| `[d` | Previous diagnostic |

### Navigation

| Key | Action |
|-----|--------|
| `Ctrl-o` | Jump back |
| `Ctrl-i` | Jump forward |

### Completion

| Key | Action |
|-----|--------|
| `Tab` | Next completion item |
| `Shift-Tab` | Previous item |
| `Enter` | Accept completion |
| `Ctrl-Space` | Trigger completion |
| `Ctrl-e` | Close completion menu |

## Adding More Languages

Mason can install servers for many languages. Check what's available:

```
:Mason
```

Browse the list. Install with `i` on any server.

Common additions:

```lua
require("mason-lspconfig").setup({
    ensure_installed = {
        "pyright",      -- Python
        "lua_ls",       -- Lua
        "ts_ls",        -- TypeScript/JavaScript
        "rust_analyzer", -- Rust
        "gopls",        -- Go
    },
})

-- Then configure each one:
lspconfig.pyright.setup({})
lspconfig.lua_ls.setup({})
lspconfig.ts_ls.setup({})
-- etc.
```

Each language server has its own quirks and options. The defaults usually work.

## Checkpoint

You should now be able to:

1. **Get autocompletion** — Type `store.` and see methods
2. **Jump to definition** — `gd` on any symbol
3. **See hover docs** — `K` shows documentation
4. **Find references** — `gr` shows all usages
5. **Rename symbols** — `<leader>rn` renames everywhere
6. **Navigate diagnostics** — `]d`, `[d`, `<leader>d`
7. **See better highlighting** — Treesitter parsing your code

Your config: ~150 lines and it's now a real IDE.

## Common Issues

**"No completion menu appears"**

- Is pyright installed? Check `:Mason`
- Is LSP attached? Check `:LspInfo` while in a Python file
- Did you save the config and restart Neovim?

**"gd doesn't work"**

- Check `:LspInfo` — is a client attached?
- Try `:LspStart` if nothing is attached
- Make sure you're in a file that pyright recognizes (`.py`)

**"Mason shows errors installing"**

- You need npm/node for some servers
- Try `:MasonLog` to see what failed
- Some servers need specific system dependencies

**"Treesitter shows errors"**

- Run `:TSUpdate` to update parsers
- Check `:TSInstallInfo` for status
- Ensure you have a C compiler (gcc/clang) for parser compilation

**"Completion is slow"**

- Large projects can be slow initially while pyright indexes
- Check if pyright is still loading: `:LspInfo`
- Consider adding a `pyrightconfig.json` to exclude folders

**"Too many diagnostics"**

You can filter what shows:

```lua
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})
```

Set `virtual_text = false` to hide inline messages.

## Key Takeaways

1. **LSP separates concerns** — Neovim edits, language servers understand. Clean architecture.

2. **Mason makes installation easy** — One UI to install any language server. No manual downloads.

3. **The keybindings are standard** — `gd`, `gr`, `K` are the same in almost every Neovim config. Learn once, use everywhere.

4. **Treesitter is worth it** — Better highlighting is subtle but compounds over hours of reading code.

5. **Start with one language** — Get Python working. Add more languages as you need them.

6. **The jump list is your friend** — `gd` to dive in, `Ctrl-o` to surface. Navigate code like hyperlinks.

## The Insight

Your Neovim now does what VS Code does. Autocompletion, go-to-definition, rename, diagnostics — all of it.

But it does it with your keybindings, your layout, your workflow. No electron, no 500MB of RAM, no mouse required.

This is the inflection point. Before this lesson, Neovim was "fast but limited." After this lesson, it's "fast and fully capable."

The next two lessons connect this to AI. You have IDE features. Soon you'll have Claude editing your files while you review with all these tools.

---

[Next: Lesson 07 - Terminal Integration →](../07-terminal-integration/)
