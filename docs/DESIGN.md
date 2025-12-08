# vim-in-the-ai-age: Project Design Document

## Overview

**Repository name:** `vim-in-the-ai-age`

**Description:** Learn Neovim by building real projects with AI pair programming. From zero to Claude Code integration.

**Tagline:** A hands-on guide to learning Neovim in 2025 - not through flashcards, but by building real projects alongside AI coding assistants.

**Created by:** Pyro

---

## The Problem

Most Vim/Neovim tutorials are:

1. **Outdated** - written 5-10+ years ago, before modern plugin ecosystems (lazy.nvim, native LSP, treesitter)
2. **Abstract** - "here are 200 keybindings to memorize" instead of learning through usage
3. **Disconnected from modern workflows** - no integration with AI coding tools that are now standard
4. **Config-porn focused** - showing off 1000-line configs instead of teaching progression
5. **Not project-based** - artificial exercises instead of building something real

The gap: **Nobody teaches Vim as part of an AI-augmented development workflow.**

---

## The Solution

A project-based learning path where:

1. **You build real things** - starting with a terminal task manager (`tsk`)
2. **Config evolves naturally** - start minimal, add features as you need them
3. **AI integration is woven throughout** - not an afterthought chapter
4. **Opinionated choices** - we pick the best tools, not "here are 12 options"
5. **Muscle memory through practice** - each phase reinforces previous skills

---

## Target Audience

- Developers curious about Vim but intimidated by the learning curve
- VS Code/IDE users who want terminal-native workflows
- Anyone using AI coding tools (Claude Code, Copilot, Cursor) who wants a more composable editor
- Experienced developers who tried Vim before but it "didn't stick"

**Assumed knowledge:**
- Basic terminal usage
- Some programming experience (Python used for examples)
- No prior Vim knowledge required

---

## Core Philosophy

### 1. Learn by Doing
Every concept is introduced because you need it to accomplish a real task. No "here's a feature you might use someday."

### 2. Progressive Config
The Neovim configuration starts at ~15 lines and grows organically. Students understand every line because they added it for a reason.

### 3. Vim Grammar Over Memorization
Teach the composable nature of Vim (verbs + nouns + modifiers) early. Once you understand `d2w`, you understand `c2w`, `y2w`, etc.

### 4. AI as Pair Programmer
Position Claude Code (and other AI tools) as a natural part of the workflow, not a crutch or replacement.

### 5. Opinionated Defaults
We choose:
- **Neovim** over Vim (Lua config, native LSP, better async)
- **lazy.nvim** for plugin management
- **telescope.nvim** for fuzzy finding (inside Neovim)
- **fzf** for shell fuzzy finding (in terminal splits)
- **catppuccin** as default theme (easy on eyes, well-maintained)
- **pyright** for Python LSP
- **toggleterm.nvim** for terminal integration

---

## Repository Structure

```
vim-in-the-ai-age/
├── README.md                           # Overview, quick start, table of contents
├── CONTRIBUTING.md                     # How to contribute lessons
├── LICENSE                             # MIT
│
├── docs/
│   ├── why-vim-in-2025.md              # The pitch - why learn this now
│   ├── prerequisites.md                # What you need before starting
│   ├── keybinding-reference.md         # Full reference with lesson context
│   │
│   └── cheatsheets/
│       ├── vim-grammar.md              # Operators, motions, text objects
│       ├── keybindings.md              # Quick reference card
│       └── ai-workflows.md             # Review loop, refactor workflow, patterns
│
├── lessons/
│   ├── 00-setup/
│   │   ├── README.md                   # Installation, first launch, escaping vim
│   │   └── checkpoints.md              # How to verify you completed this phase
│   │
│   ├── 01-survival/
│   │   ├── README.md                   # Basic modes, hjkl, :w, :q, insert mode
│   │   ├── init.lua                    # Config state after this lesson
│   │   └── exercises.md                # Practice tasks
│   │
│   ├── 02-navigation/
│   │   ├── README.md                   # Words, lines, files, search
│   │   ├── init.lua
│   │   └── exercises.md
│   │
│   ├── 03-editing-grammar/
│   │   ├── README.md                   # The verb+noun system, operators, motions
│   │   ├── init.lua
│   │   └── exercises.md
│   │
│   ├── 04-files-and-buffers/
│   │   ├── README.md                   # Splits, buffers, tabs, project navigation
│   │   ├── init.lua
│   │   └── exercises.md
│   │
│   ├── 05-plugins-and-fuzzy-finding/
│   │   ├── README.md                   # lazy.nvim, telescope, nvim-tree
│   │   ├── init.lua
│   │   └── exercises.md
│   │
│   ├── 06-lsp-and-completion/
│   │   ├── README.md                   # mason, lspconfig, nvim-cmp, treesitter
│   │   ├── init.lua
│   │   └── exercises.md
│   │
│   ├── 07-terminal-integration/
│   │   ├── README.md                   # toggleterm, fzf shell integration, running code
│   │   ├── init.lua
│   │   └── exercises.md
│   │
│   ├── 08-claude-code-basics/
│   │   ├── README.md                   # The side-by-side workflow, autoread, review loop
│   │   ├── init.lua
│   │   └── exercises.md                # Hands-on tasks with tsk project
│   │
│   ├── 09-ai-assisted-patterns/
│   │   ├── README.md                   # Git integration, refactor workflow, multi-file edits
│   │   ├── init.lua
│   │   └── exercises.md
│   │
│   └── 10-tmux-and-advanced/
│       ├── README.md                   # tmux integration, vim-tmux-navigator
│       ├── init.lua
│       ├── tmux.conf                   # Recommended tmux config
│       └── workflows.md
│
├── projects/
│   ├── tsk/                            # The tutorial project - terminal task manager
│   │   ├── README.md                   # Project overview, what you'll build
│   │   ├── pyproject.toml
│   │   ├── src/
│   │   │   └── tsk/
│   │   │       ├── __init__.py
│   │   │       ├── main.py
│   │   │       └── models.py
│   │   └── tests/
│   │       └── test_models.py
│   │
│   └── future-projects/                # Placeholder for additional projects
│       └── .gitkeep
│
├── configs/
│   ├── minimal/
│   │   └── init.lua                    # Bare minimum config (~15 lines)
│   ├── intermediate/
│   │   └── init.lua                    # After plugins lesson (~100 lines)
│   └── complete/
│       └── init.lua                    # Full config after all lessons
```

---

## The First Project: tsk (Terminal Task Manager)

A simple but real CLI task manager that teaches all core Neovim skills.

### Why This Project?

1. **Small enough to complete** - not overwhelming
2. **Multiple files** - forces learning navigation, splits, fuzzy finding
3. **Real dependencies** - introduces running code, package management
4. **Testable** - can add tests to teach test-running workflows
5. **Extendable** - easy to add features for AI-assisted lessons

### Tech Stack

- **Python 3.11+**
- **uv** for package/project management
- **typer** for CLI framework
- **JSON file storage** (simple, no database complexity)

### Features (Final State)

```
tsk add "Buy groceries"      # Add a task
tsk list                     # List all tasks
tsk done 1                   # Mark task #1 complete
tsk rm 1                     # Delete task #1
tsk clear                    # Remove completed tasks (added via AI lesson)
```

---

## tsk Project Progression

**This is the heart of the tutorial.** We don't hand you a finished project to practice on. We BUILD tsk together, lesson by lesson. Each Vim feature is introduced because the project demands it.

### The Philosophy

Every lesson follows this pattern:
1. **Project need emerges** - "We need to do X with our code"
2. **Vim feature introduced** - "Here's how Vim handles X"
3. **Apply to tsk** - "Let's use this to build the next piece"
4. **Practice exercises** - "Reinforce on what you just wrote"

### Lesson-by-Lesson Progression

| Lesson | tsk State | What We Build | Why We Need This Vim Feature |
|--------|-----------|---------------|------------------------------|
| 00 | Nothing | - | Just setting up |
| 01 | Nothing | - | Learning to survive |
| 02 | **Project created** | Skeleton `main.py` with CLI structure | Need to navigate the code we're about to write |
| 03 | Single file | `Task` class, `add` and `list` commands (in-memory) | Need editing grammar to write code efficiently |
| 04 | **Multi-file** | Split into `models.py` + `main.py`, add persistence | Multiple files = need splits and buffers |
| 05 | Growing | Add `done`, `rm`, `clear` + `tests/` folder | Need fuzzy finding to navigate growing project |
| 06 | Typed | Add proper type hints, improve code quality | Want autocomplete, go-to-definition, rename |
| 07 | Runnable | Ready to execute and test | Need terminal to run `tsk list`, pytest |
| 08-09 | **Extended** | Add priority, tags, filters (with Claude) | AI extends our project, we review changes |

### Detailed Progression

#### Lesson 02: Navigation → Create tsk Skeleton

**What we create:**
```bash
uv init --lib --name tsk
uv add typer
```

```
projects/tsk/
├── pyproject.toml          # Created by uv init
├── src/tsk/
│   ├── __init__.py         # Created by uv init
│   └── main.py             # We write this
└── uv.lock                 # Created by uv add
```

**main.py at end of lesson 02:**
```python
import typer

app = typer.Typer(help="Terminal task manager")


@app.command()
def add(task: str):
    """Add a new task."""
    print(f"TODO: Add task: {task}")


@app.command("list")
def list_tasks():
    """List all tasks."""
    print("TODO: List tasks")


if __name__ == "__main__":
    app()
```

**Why navigation matters:** You just created a file. Now navigate it - jump between functions, search for "TODO", move by words to edit placeholders.

#### Lesson 03: Editing Grammar → Implement Core Logic

**What we add:**
- `Task` dataclass in `main.py`
- Working `add` command (stores in list)
- Working `list` command (prints tasks)

**main.py at end of lesson 03:**
```python
import typer
from dataclasses import dataclass
from enum import Enum

app = typer.Typer(help="Terminal task manager")

# In-memory storage (we'll add persistence in lesson 04)
tasks: list["Task"] = []
next_id: int = 1


class Status(Enum):
    TODO = "todo"
    DONE = "done"


@dataclass
class Task:
    id: int
    text: str
    status: Status = Status.TODO


@app.command()
def add(task: str):
    """Add a new task."""
    global next_id
    t = Task(id=next_id, text=task)
    tasks.append(t)
    next_id += 1
    print(f"✓ Added task #{t.id}: {t.text}")


@app.command("list")
def list_tasks():
    """List all tasks."""
    if not tasks:
        print("No tasks")
        return
    for t in tasks:
        status = "✓" if t.status == Status.DONE else "○"
        print(f"  {status} [{t.id}] {t.text}")


if __name__ == "__main__":
    app()
```

**Why editing grammar matters:** We're writing real code. `ciw` to change a word, `dd` to delete a line, `yy` to copy. This is where Vim starts to shine.

#### Lesson 04: Files and Buffers → Refactor to Multi-File

**What we change:**
- Extract `Task`, `Status`, `TaskStore` to `models.py`
- Add JSON persistence
- `main.py` becomes thin CLI layer

**Why splits/buffers matter:** "This file is getting long. Let's split it." Now you need to work with `main.py` and `models.py` side by side. Lesson teaches splits, switching buffers.

**Project structure after lesson 04:**
```
projects/tsk/
├── pyproject.toml
└── src/tsk/
    ├── __init__.py
    ├── main.py             # CLI commands only
    └── models.py           # Task, Status, TaskStore
```

#### Lesson 05: Plugins and Fuzzy Finding → Complete Features

**What we add:**
- `done` command
- `rm` command
- `clear` command
- `tests/test_models.py`

**Why fuzzy finding matters:** Project now has 4+ files. Typing `:e src/tsk/models.py` is tedious. `<leader>ff` and telescope make navigation instant.

**Project structure after lesson 05:**
```
projects/tsk/
├── pyproject.toml
├── src/tsk/
│   ├── __init__.py
│   ├── main.py
│   └── models.py
└── tests/
    └── test_models.py
```

#### Lesson 06: LSP and Completion → Type Safety

**What we improve:**
- Full type hints everywhere
- Proper dataclass usage
- Maybe add a helper function or two

**Why LSP matters:** "What methods does TaskStore have?" With LSP: hover and see. "Rename this variable everywhere?" LSP rename. Autocomplete while typing.

#### Lesson 07: Terminal Integration → Run Everything

**What we do:**
- Run `tsk add "Test"` from Neovim terminal
- Run `pytest` to verify tests pass
- Iterate: edit code, run, see results

**Why terminal matters:** We've been writing code. Now we RUN it. No switching windows, no alt-tab. Edit in one split, test in another.

#### Lessons 08-09: Claude Code → Extend with AI

**What Claude adds:**
- Priority field (HIGH/MEDIUM/LOW)
- Tags system
- Filter flags (`tsk list --priority high`)
- More tests

**Why AI workflow matters:** This is the payoff. You know Vim. You have a real project. Now watch Claude extend it while you review changes, navigate diffs, and run tests - all with the skills you've built.

### The Key Insight

**Each lesson has project stakes.**

- Lesson 02 isn't "learn w and b for navigation." It's "we're starting a project and need to move around the skeleton we just created."
- Lesson 04 isn't "learn about buffers." It's "our file got too big, we need to split it, and now we need to work with both files."
- Lesson 07 isn't "here's toggleterm." It's "we've been writing code for 5 lessons and never ran it. Let's fix that."

The Vim features serve the project. Not the other way around.

---

### Final Code Reference

#### pyproject.toml
```toml
[project]
name = "tsk"
version = "0.1.0"
description = "Terminal task manager - vim-in-the-ai-age tutorial project"
readme = "README.md"
requires-python = ">=3.11"
dependencies = [
    "typer>=0.9.0",
]

[project.scripts]
tsk = "tsk.main:app"

[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"
```

#### src/tsk/models.py
```python
from dataclasses import dataclass, field
from datetime import datetime
from enum import Enum
import json
from pathlib import Path


class Status(Enum):
    TODO = "todo"
    DONE = "done"


@dataclass
class Task:
    id: int
    text: str
    status: Status = Status.TODO
    created: str = field(default_factory=lambda: datetime.now().isoformat())

    def to_dict(self) -> dict:
        return {
            "id": self.id,
            "text": self.text,
            "status": self.status.value,
            "created": self.created,
        }

    @classmethod
    def from_dict(cls, data: dict) -> "Task":
        return cls(
            id=data["id"],
            text=data["text"],
            status=Status(data["status"]),
            created=data["created"],
        )


class TaskStore:
    def __init__(self, path: Path | None = None):
        self.path = path or Path.home() / ".tsk" / "tasks.json"
        self.path.parent.mkdir(parents=True, exist_ok=True)
        self.tasks: list[Task] = []
        self._load()

    def _load(self):
        if self.path.exists():
            data = json.loads(self.path.read_text())
            self.tasks = [Task.from_dict(t) for t in data]

    def _save(self):
        data = [t.to_dict() for t in self.tasks]
        self.path.write_text(json.dumps(data, indent=2))

    def add(self, text: str) -> Task:
        task_id = max((t.id for t in self.tasks), default=0) + 1
        task = Task(id=task_id, text=text)
        self.tasks.append(task)
        self._save()
        return task

    def complete(self, task_id: int) -> Task | None:
        for task in self.tasks:
            if task.id == task_id:
                task.status = Status.DONE
                self._save()
                return task
        return None

    def delete(self, task_id: int) -> bool:
        for i, task in enumerate(self.tasks):
            if task.id == task_id:
                self.tasks.pop(i)
                self._save()
                return True
        return False

    def clear_completed(self) -> int:
        original_count = len(self.tasks)
        self.tasks = [t for t in self.tasks if t.status != Status.DONE]
        self._save()
        return original_count - len(self.tasks)

    def list_all(self) -> list[Task]:
        return self.tasks
```

#### src/tsk/main.py
```python
import typer
from tsk.models import TaskStore, Status

app = typer.Typer(help="Terminal task manager")


@app.command()
def add(task: str):
    """Add a new task."""
    store = TaskStore()
    t = store.add(task)
    print(f"✓ Added task #{t.id}: {t.text}")


@app.command("list")
def list_tasks():
    """List all tasks."""
    store = TaskStore()
    tasks = store.list_all()
    if not tasks:
        print("No tasks")
        return
    for t in tasks:
        status = "✓" if t.status == Status.DONE else "○"
        print(f"  {status} [{t.id}] {t.text}")


@app.command()
def done(task_id: int):
    """Mark a task as complete."""
    store = TaskStore()
    task = store.complete(task_id)
    if task:
        print(f"✓ Completed: {task.text}")
    else:
        print(f"Task #{task_id} not found")


@app.command()
def rm(task_id: int):
    """Delete a task."""
    store = TaskStore()
    if store.delete(task_id):
        print(f"Deleted task #{task_id}")
    else:
        print(f"Task #{task_id} not found")


@app.command()
def clear():
    """Remove all completed tasks."""
    store = TaskStore()
    count = store.clear_completed()
    print(f"Cleared {count} completed task(s)")


if __name__ == "__main__":
    app()
```

---

## Neovim Configuration Progression

### Phase 1: Survival (~15 lines)
```lua
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.clipboard = "unnamedplus"

vim.g.mapleader = " "

vim.keymap.set("i", "jk", "<Esc>")
```

### Phase 2: Window Navigation (add)
```lua
vim.opt.scrolloff = 8
vim.opt.updatetime = 50

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
```

### Phase 3: Plugin Manager + Core Plugins (add)
```lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
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

### Phase 4: Terminal (add to lazy.setup)
```lua
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        keys = {
            { "<C-\\>", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Toggle terminal" },
            { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float terminal" },
            { "<leader>tv", "<cmd>ToggleTerm direction=vertical size=80<cr>", desc = "Vertical terminal" },
        },
        config = function()
            require("toggleterm").setup({ shell = vim.o.shell })
        end,
    },
```

### Phase 5: LSP (add to lazy.setup)
```lua
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
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
                    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
                end,
            })
        end,
    },
```

### Phase 6: Autocompletion (add to lazy.setup)
```lua
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
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
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
```

### Phase 7: Treesitter (add to lazy.setup)
```lua
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "python", "lua", "json", "markdown" },
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },
```

### Phase 8: Claude Code Integration (add after lazy.setup)
```lua
-- Auto-reload files changed externally (by Claude Code)
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
    command = "checktime",
})

-- Quick Claude Code terminal (vertical split, 40% width)
vim.api.nvim_create_user_command("Claude", function()
    local Terminal = require("toggleterm.terminal").Terminal
    local claude = Terminal:new({
        cmd = "claude",
        direction = "vertical",
        size = function() return math.floor(vim.o.columns * 0.4) end,
        close_on_exit = false,
    })
    claude:toggle()
end, {})
vim.keymap.set("n", "<leader>cc", "<cmd>Claude<cr>", { desc = "Claude Code" })

-- Quick yank current file path (useful for telling Claude which file)
vim.keymap.set("n", "<leader>yp", function()
    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", path)
    print("Copied: " .. path)
end, { desc = "Yank file path" })

-- Quick yank current file path + line number
vim.keymap.set("n", "<leader>yl", function()
    local path = vim.fn.expand("%:p") .. ":" .. vim.fn.line(".")
    vim.fn.setreg("+", path)
    print("Copied: " .. path)
end, { desc = "Yank file:line" })
```

### Phase 9: Git Integration for AI Review (add to lazy.setup)
```lua
    -- See what Claude changed
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                on_attach = function(bufnr)
                    local gs = require("gitsigns")
                    local opts = { buffer = bufnr }

                    -- Navigation between hunks (changes)
                    vim.keymap.set("n", "]c", gs.next_hunk, opts)
                    vim.keymap.set("n", "[c", gs.prev_hunk, opts)

                    -- Preview what changed
                    vim.keymap.set("n", "<leader>hp", gs.preview_hunk, opts)

                    -- Reset a hunk if Claude got it wrong
                    vim.keymap.set("n", "<leader>hr", gs.reset_hunk, opts)

                    -- Blame line (who wrote this?)
                    vim.keymap.set("n", "<leader>hb", gs.blame_line, opts)
                end,
            })
        end,
    },
```

---

## Lesson Structure Template

Each lesson follows this structure:

```markdown
# Lesson N: [Title]

## What You'll Learn
- Bullet points of skills

## Prerequisites
- Previous lessons completed
- Any tools needed

## Context
Why we need this skill right now in our project.

## The Lesson
Step-by-step instructions with:
- Exact keystrokes to type
- Expected output/behavior
- Explanations of what's happening

## New Keybindings Summary
| Keys | Action |
|------|--------|
| ...  | ...    |

## Practice Exercises
Specific tasks to reinforce the skill.

## Checkpoint
How to verify you've completed this lesson successfully.

## Common Issues
Troubleshooting section.

## Config Changes
The exact lines added to init.lua (if any).
```

---

## Lesson 07: Terminal Integration (Detailed Outline)

### The Core Concept

The terminal is where everything comes together. You'll run code, tests, git commands, and shell utilities -- all without leaving Neovim.

We use two complementary tools:
- **toggleterm.nvim** -- Terminal splits inside Neovim
- **fzf** -- Fuzzy finding in the shell (complements telescope)

### Why Both Telescope AND fzf?

| Tool | Where | Use Case |
|------|-------|----------|
| Telescope | Inside Neovim | Find files, grep code, navigate buffers |
| fzf | In shell/terminal | Command history, quick file open, directory jumping |

Telescope is Neovim-native. fzf works everywhere -- in your toggleterm splits, tmux panes, and regular terminal. They complement each other.

### What You'll Learn

1. **toggleterm basics** -- Horizontal, vertical, and floating terminals
2. **Running code** -- Execute Python scripts, run pytest
3. **Terminal navigation** -- Switch between terminal and editor
4. **fzf shell integration** -- Ctrl-R history, Ctrl-T files, Alt-C directories
5. **Opening files from shell** -- `nvim $(fzf)` and `**<Tab>` completion

### Config Changes (toggleterm)

```lua
{
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
        { "<C-\\>", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Toggle terminal" },
        { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float terminal" },
        { "<leader>tv", "<cmd>ToggleTerm direction=vertical size=80<cr>", desc = "Vertical terminal" },
    },
    config = function()
        require("toggleterm").setup({ shell = vim.o.shell })
    end,
},
```

### Installing fzf

```bash
# macOS
brew install fzf
$(brew --prefix)/opt/fzf/install  # Install shell integration

# Ubuntu/Debian
sudo apt install fzf

# Arch
sudo pacman -S fzf

# Manual (any system)
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

### fzf Shell Keybindings

After installation, these work in any terminal (including toggleterm):

| Keys | Action |
|------|--------|
| `Ctrl-R` | Fuzzy search command history |
| `Ctrl-T` | Fuzzy find files, insert path |
| `Alt-C` | Fuzzy find directories, cd into it |

### fzf Workflows

**Quick file open:**
```bash
nvim $(fzf)           # Select file with fzf, open in nvim
nvim $(fzf --preview 'cat {}')  # With preview
```

**Fuzzy path completion:**
```bash
nvim **<Tab>          # Fuzzy complete file path
cd **<Tab>            # Fuzzy complete directory
```

**Command history:**
```bash
# Press Ctrl-R, type partial command, select from matches
```

### Exercises

| Exercise | Task | Skills Practiced |
|----------|------|------------------|
| Run tsk | Open terminal, run `python -m tsk list` | `<C-\>` toggle |
| Run tests | Run pytest in vertical split | `<leader>tv`, pytest |
| History search | Find a previous git command with Ctrl-R | fzf shell integration |
| Quick open | Use `nvim $(fzf)` to open a project file | fzf + nvim integration |
| Path completion | Use `**<Tab>` to complete a nested path | fzf completion |

### Terminal Mode Keybindings

| Keys | Mode | Action |
|------|------|--------|
| `Ctrl-\ Ctrl-n` | Terminal | Exit to normal mode |
| `i` or `a` | Normal (in terminal) | Back to terminal mode |
| `<C-\>` | Any | Toggle terminal |

### Common Issues

- **Ctrl-R doesn't fuzzy search**: Run fzf's install script with shell integration
- **Alt-C doesn't work**: Some terminals capture Alt. Try `Esc-c` or configure terminal
- **Terminal mode confusion**: `Ctrl-\ Ctrl-n` always gets you back to normal mode

---

## Lesson 08: Claude Code Basics (Detailed Outline)

### The Core Concept

Claude Code and Neovim are both file-based and terminal-native. They complement each other naturally:
- Claude edits files → Neovim shows files
- Neovim's splits → Claude visible while coding
- Vim motions → fast navigation of Claude's changes
- Terminal integration → everything in one place

### The Side-by-Side Workflow

```
┌─────────────────────────────────┬────────────────────────┐
│                                 │                        │
│           Neovim                │     Claude Code        │
│         (your code)             │     (AI assistant)     │
│                                 │                        │
│   - Edit files                  │   - Ask questions      │
│   - Navigate with motions       │   - Request changes    │
│   - Review changes              │   - Debug together     │
│   - Run tests                   │                        │
│                                 │                        │
└─────────────────────────────────┴────────────────────────┘
```

### What You'll Learn

1. **Setting up autoread** - Files reload automatically when Claude edits them
2. **The review loop** - Claude edits → you review → iterate
3. **Yanking context** - Select code, send to Claude for questions
4. **The `:Claude` command** - Quick toggle for side-by-side workflow

### Config Changes

```lua
-- Auto-reload files changed externally
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
    command = "checktime",
})

-- Claude Code terminal command
-- <leader>cc to toggle
-- <leader>yp to yank file path
-- <leader>yl to yank file:line
```

### Exercises (Using tsk Project)

| Exercise | What You Ask Claude | Skills Practiced |
|----------|--------------------|--------------------|
| Add priority field | "Add a priority field (high/medium/low) to the Task dataclass in models.py" | Watch autoread reload, review with `gd` |
| Write a test | "Write a test for TaskStore.add() in test_models.py" | Open new file with telescope, run pytest |
| Fix a bug | Yank an error message, ask "why is this failing?" | `"+y` to clipboard, iterate on fix |
| Add CLI flag | "Add --priority flag to filter tasks in the list command" | Multi-file review (models.py + main.py) |

### The Review Loop (Key Workflow)

1. Ask Claude to make a change
2. Claude edits the file(s)
3. Neovim auto-reloads (or `:e` to force)
4. Review with:
   - `gd` - go to definition (did Claude use the right function?)
   - `K` - hover docs (does this type make sense?)
   - `gr` - find references (did Claude update all usages?)
5. Run tests: `:!pytest` or use terminal split
6. If wrong, tell Claude and iterate

### Common Issues

- **File doesn't reload**: Check `autoread` is set, try `:e` manually
- **Claude can't find file**: Use `<leader>yp` to copy exact path
- **Lost in changes**: Use telescope `<leader>ff` to find files Claude touched

---

## Lesson 09: AI-Assisted Patterns (Detailed Outline)

### What You'll Learn

1. **Git integration** - See exactly what Claude changed
2. **Hunk navigation** - Jump between changes with `]c` / `[c`
3. **Selective reset** - Undo specific Claude changes you don't like
4. **The refactor workflow** - Ask, review, test, iterate

### The Key Insight

When Claude makes changes, you need to:
1. See what changed (gitsigns highlights)
2. Navigate changes quickly (`]c` / `[c`)
3. Decide per-change: keep or reset (`<leader>hr`)
4. Verify with tests before committing

### Config Changes

```lua
-- gitsigns.nvim for inline git diff
-- ]c / [c - jump between hunks
-- <leader>hp - preview hunk
-- <leader>hr - reset hunk (undo that change)
-- <leader>hb - blame line
```

### The Refactor Workflow

```
┌─────────────────────────────────────────────────────────┐
│  1. Identify what needs refactoring                     │
│     - Code smell, duplication, unclear logic            │
│                                                         │
│  2. Ask Claude                                          │
│     - "Refactor TaskStore to use a context manager"     │
│     - Be specific about what you want                   │
│                                                         │
│  3. Review changes                                      │
│     - ]c / [c to jump through hunks                     │
│     - <leader>hp to preview each change                 │
│     - gd / K / gr to understand the code                │
│                                                         │
│  4. Test immediately                                    │
│     - :!pytest (or terminal)                            │
│     - Don't commit until tests pass                     │
│                                                         │
│  5. Iterate or reset                                    │
│     - Tests fail? Tell Claude, iterate                  │
│     - Bad change? <leader>hr to reset that hunk         │
│     - Good? Commit with clear message                   │
└─────────────────────────────────────────────────────────┘
```

### Exercises

| Exercise | Task | Skills Practiced |
|----------|------|------------------|
| Review a refactor | Ask Claude to extract a helper function, review each hunk | `]c`, `[c`, `<leader>hp` |
| Partial accept | Ask for a change, reset one hunk you don't like | `<leader>hr` to reset |
| Debug with context | Tests fail after Claude's change, yank error + diff context | Iterative debugging |
| Multi-file refactor | Ask Claude to rename a method across files, review all changes | Telescope + hunk navigation |

### Patterns to Teach

**The "Explain This" Pattern:**
```
1. Visual select confusing code (V + motion)
2. Yank to clipboard: "+y
3. Ask Claude: "What does this code do?"
4. Faster than reading docs sometimes
```

**The "Fix This Error" Pattern:**
```
1. Error appears in terminal
2. Yank the full traceback
3. Ask Claude: "Why is this failing?"
4. Claude explains + suggests fix
5. Review the fix with gitsigns
```

**The "Add Tests" Pattern:**
```
1. Write implementation (or have Claude write it)
2. Ask: "Write tests for [function]"
3. Review test file with telescope
4. Run: :!pytest -v
5. Iterate until green
```

### What NOT to Do

- Don't blindly accept all changes - review each hunk
- Don't skip tests - always verify before committing
- Don't ask vague questions - be specific about what you want
- Don't fight Claude - if it's not understanding, rephrase

---

## Future Lessons (Post-MVP)

### Advanced AI Workflows

1. **Large Refactors**
   - Multi-file changes with Claude
   - Using quickfix list to jump through changes
   - Staging partial changes with gitsigns

2. **AI-Assisted Debugging**
   - Quickfix integration for errors
   - Yanking stack traces to Claude
   - Iterative fix-and-test loops

3. **Documentation Generation**
   - Docstring workflows
   - README generation patterns
   - Code-to-docs with AI

### Advanced Neovim Lessons

1. **Macros and Automation**
   - Recording and playing macros
   - When macros beat AI

2. **Custom Commands and Functions**
   - Writing Lua functions
   - Project-specific tooling

3. **Git Integration**
   - gitsigns.nvim
   - fugitive or lazygit
   - AI-assisted commit messages

4. **Debugging in Neovim**
   - nvim-dap setup
   - Python debugging
   - Breakpoints and stepping

### Additional Projects

1. **API Client** - HTTP requests, JSON handling
2. **Static Site Generator** - Multi-file, templates
3. **Discord Bot** - Async Python, external APIs

---

## Writing Style Guide

### Tone
- Direct, no fluff
- Assume intelligence, don't over-explain
- Occasional humor is fine
- "We" and "you" - collaborative

### Code Examples
- Always complete and runnable
- No "..." truncation unless showing a diff
- Include expected output where helpful

### Formatting
- Use straight quotes (' and ") not curly
- No em dashes (use -- or -)
- Code blocks with language specified
- Tables for keybinding references

---

## Technical Requirements

### For Students
- Linux/macOS/WSL2
- Neovim 0.9+ (0.10+ preferred)
- Python 3.11+
- uv (Python package manager)
- git
- ripgrep (for telescope live_grep)
- fzf (for shell fuzzy finding)
- Claude Code (for AI lessons)

### For Development
- Same as above
- Ability to test on fresh Neovim install

---

## MVP Scope

**Version 1.0 includes:**
- Lessons 00-08 (through Claude Code basics)
- Complete tsk project
- All config stages
- Basic cheatsheets

**Version 1.1 adds:**
- Lessons 09-10 (advanced AI, tmux)
- Additional exercises
- Video walkthroughs (optional)

**Version 2.0 adds:**
- Additional projects
- Community contributions
- Multiple language tracks (beyond Python)

---

## Success Metrics

1. **Completion rate** - Can people finish the tutorial?
2. **Config adoption** - Are people using the configs we provide?
3. **Community growth** - Stars, forks, contributions
4. **Feedback quality** - Are people actually learning Vim?

---

## Notes for Implementation

When working on this project:

1. **Test everything on fresh Neovim** - Don't assume plugins are installed
2. **Keep lessons atomic** - One concept per lesson where possible
3. **Config must work at each stage** - No broken intermediate states
4. **Platform differences** - Note macOS/Linux/WSL variations
5. **Error handling** - Include "if this doesn't work" sections

---

## Quick Reference: Key Bindings We Teach

| Phase | Keys | Action |
|-------|------|--------|
| 1 | `i` | Insert mode |
| 1 | `jk` | Escape to normal (custom) |
| 1 | `:w` | Save |
| 1 | `:q` | Quit |
| 2 | `hjkl` | Movement |
| 2 | `w/b` | Word forward/back |
| 2 | `gg/G` | Top/bottom of file |
| 2 | `/` | Search |
| 3 | `d` | Delete (operator) |
| 3 | `c` | Change (operator) |
| 3 | `y` | Yank (operator) |
| 3 | `ciw` | Change inner word |
| 4 | `Ctrl-w v` | Vertical split |
| 4 | `Ctrl-w hjkl` | Window navigation |
| 5 | `Space f f` | Find files |
| 5 | `Space f g` | Live grep |
| 5 | `Space e` | File tree |
| 6 | `gd` | Go to definition |
| 6 | `K` | Hover docs |
| 6 | `Space rn` | Rename |
| 7 | `Ctrl-\` | Toggle terminal |
| 8 | `Space c c` | Claude Code |
| 8 | `Space y p` | Yank file path |
| 8 | `Space y l` | Yank file:line |
| 9 | `]c` / `[c` | Next/prev git hunk |
| 9 | `Space h p` | Preview hunk |
| 9 | `Space h r` | Reset hunk |
| 9 | `Space h b` | Git blame line |

---

## Contact / Attribution

Created by Pyro - GitHub: pyros-project
Tutorial developed with Claude (Anthropic)

---

*This document serves as the complete specification for the vim-in-the-ai-age project. Any Claude instance working on this project should have full context from this document alone.*
