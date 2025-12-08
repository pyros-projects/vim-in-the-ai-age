# vim-in-the-ai-age

Learn Neovim by building real projects with AI pair programming. From zero to Claude Code integration.

## The Problem

Most Vim tutorials are mass-produced garbage from 2015. They teach you 200 keybindings through flashcard memorization, show off 1000-line configs that took years to accumulate, and completely ignore that AI coding tools exist.

The result: people bounce off Vim repeatedly because they're learning abstract commands instead of building things.

## The Solution

You learn Vim by building a real project (`tsk` - a terminal task manager) while an AI coding assistant works alongside you. The config starts at 15 lines and grows only when you need something.

No memorization. No config-porn. Just building.

## Who This Is For

- Developers curious about Vim but intimidated by the learning curve
- VS Code/IDE users who want terminal-native workflows
- Anyone using AI coding tools who wants a more composable editor
- People who tried Vim before but it "didn't stick"

**Not for you if:** You want a reference manual. This is a hands-on tutorial.

## What You'll Build

`tsk` - A terminal task manager in Python:

```bash
tsk add "Buy groceries"      # Add a task
tsk list                     # List all tasks
tsk done 1                   # Mark task #1 complete
tsk rm 1                     # Delete task #1
```

Simple enough to finish. Complex enough to learn real skills.

## Lessons

| # | Topic | What You Learn |
|---|-------|----------------|
| 00 | [Setup](lessons/00-setup/) | Install Neovim, first launch, how to exit |
| 01 | [Survival](lessons/01-survival/) | Modes, basic movement, saving, quitting |
| 02 | [Navigation](lessons/02-navigation/) | Words, lines, search, jumping around |
| 03 | [Editing Grammar](lessons/03-editing-grammar/) | The verb+noun system that makes Vim click |
| 04 | [Files & Buffers](lessons/04-files-and-buffers/) | Splits, tabs, working with multiple files |
| 05 | [Plugins](lessons/05-plugins-and-fuzzy-finding/) | lazy.nvim, telescope, file trees |
| 06 | [LSP](lessons/06-lsp-and-completion/) | Autocomplete, go-to-definition, real IDE features |
| 07 | [Terminal](lessons/07-terminal-integration/) | Run code, tests, shell commands without leaving |
| 08 | [Claude Code Basics](lessons/08-claude-code-basics/) | The side-by-side workflow, autoread, review loop |
| 09 | [AI Patterns](lessons/09-ai-assisted-patterns/) | Git integration, refactor workflows, hunk navigation |
| 10 | [tmux](lessons/10-tmux-and-advanced/) | Terminal multiplexing, the full setup |

## Quick Start

```bash
# 1. Clone this repo
git clone https://github.com/pyros-project/vim-in-the-ai-age.git
cd vim-in-the-ai-age

# 2. Check prerequisites
# See docs/prerequisites.md for full list

# 3. Start with lesson 00
cd lessons/00-setup
```

## The Config Progression

Your Neovim config grows with you:

| Stage | Lines | What's Added |
|-------|-------|--------------|
| Minimal | ~15 | Line numbers, tabs, leader key |
| Navigation | ~25 | Window movement, scrolloff |
| Plugins | ~80 | telescope, nvim-tree, theme |
| LSP | ~150 | Autocomplete, diagnostics |
| Full | ~250 | Terminal, Claude integration, git |

Each stage is a working config. No broken intermediate states.

## Cheatsheets

- [Vim Grammar](docs/cheatsheets/vim-grammar.md) - Operators, motions, text objects
- [Keybindings](docs/cheatsheets/keybindings.md) - Quick reference card
- [AI Workflows](docs/cheatsheets/ai-workflows.md) - Review loop, refactor patterns

## Philosophy

1. **Learn by doing** - Every concept introduced because you need it
2. **Progressive config** - Understand every line because you added it
3. **Vim grammar over memorization** - Learn the system, not the commands
4. **AI as pair programmer** - Not a crutch, not a replacement

## Tech Stack

- **Neovim 0.9+** (0.10 preferred)
- **Python 3.11+** with uv
- **lazy.nvim** for plugins
- **telescope.nvim** for fuzzy finding
- **Claude Code** for AI integration

## Why Vim in 2025?

Read [docs/why-vim-in-2025.md](docs/why-vim-in-2025.md) for the full pitch.

Short version: AI writes more code now. Your job is reviewing, navigating, and directing. Vim is optimized for exactly that.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT - See [LICENSE](LICENSE).

---

Built by [Pyro](https://github.com/pyros-project). Tutorial developed with Claude.

Cheers, Pyro
