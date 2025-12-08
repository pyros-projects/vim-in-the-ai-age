# Lesson 00: Setup

Install Neovim. Launch it. Understand why it's weird. Exit it.

## What You'll Learn

- Installing Neovim
- Why Vim is fundamentally different from other editors
- What "modes" are and why they exist
- How to exit (the famous question)
- Creating your config file

## Installing Neovim

Pick your platform. Run the commands.

### macOS

```bash
brew install neovim
```

### Ubuntu/Debian

The apt version is ancient. Don't use it.

```bash
# Add the PPA for actual current versions
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt install neovim
```

Or grab the AppImage:

```bash
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim
```

### Arch

```bash
sudo pacman -S neovim
```

### Windows

Use WSL2. Seriously. Install Ubuntu in WSL, then follow the Ubuntu instructions.

Native Windows Neovim exists but path handling is pain.

### Verify

```bash
nvim --version
```

Should show `NVIM v0.9.x` or higher. 0.10+ preferred.

If it shows something older, you installed the wrong package. Go back and use the PPA or Homebrew.

## Install the Other Stuff

While you're here, install everything else from [prerequisites](../../docs/prerequisites.md):

```bash
# Python 3.11+
python3 --version

# uv (if you don't have it)
curl -LsSf https://astral.sh/uv/install.sh | sh

# ripgrep (required for telescope search)
# macOS: brew install ripgrep
# Ubuntu: sudo apt install ripgrep
# Arch: sudo pacman -S ripgrep

# fzf (for shell fuzzy finding)
# macOS: brew install fzf && $(brew --prefix)/opt/fzf/install
# Ubuntu: sudo apt install fzf
# Arch: sudo pacman -S fzf
```

## Launch Neovim

```bash
nvim
```

You'll see a splash screen. Press any key to dismiss it.

Now stop. Look at your cursor. Try typing something.

Nothing happens. Or weird things happen. Letters appear but not where you expect. You press `j` and the cursor moves down instead of typing "j".

**This is the moment most people panic and Google "how to exit vim".**

But you're going to understand what's happening instead.

## The Big Idea: Modes

Here's the fundamental difference between Vim and every other editor you've used:

**In VS Code/Sublime/Notepad:** The editor is always in "typing mode". Press a key, that letter appears. Every key is for inserting text. To do anything else (save, copy, move), you need modifier keys (Ctrl, Cmd, Alt) or reach for the mouse.

**In Vim:** The editor has multiple *modes*. Each mode changes what your keys do.

This sounds weird until you realize: **you spend more time navigating and editing existing code than typing new code**. Vim optimizes for that reality.

### The Three Modes You'll Use

**Normal Mode** (where you are now)
- Keys are *commands*, not characters
- `j` means "move down", not "type the letter j"
- `d` means "delete", `w` means "word", `dw` means "delete word"
- This is your home base. You navigate, delete, copy, paste - all without modifier keys

**Insert Mode** (for typing text)
- Press `i` to enter from Normal mode
- Now it works like a "normal" editor - keys type characters
- Press `Esc` (or `jk` once we set that up) to return to Normal mode

**Command Mode** (for running commands)
- Press `:` from Normal mode
- Type a command like `w` (save) or `q` (quit)
- Press Enter to execute, then you're back in Normal mode

### Why This Is Actually Better

Think about what you do in a code editor:

1. Navigate to a location (scroll, find, jump to definition)
2. Make a small edit (change a variable name, delete a line, copy a block)
3. Navigate somewhere else
4. Make another edit
5. Repeat

In VS Code, every one of those navigation and edit actions requires either:
- Mouse movement (slow, hand leaves keyboard)
- Ctrl/Cmd + some key (awkward finger stretches)
- Arrow keys (far from home row)

In Vim Normal mode, your fingers never leave home row:
- `j/k` to move down/up
- `w/b` to move by words
- `dd` to delete a line
- `ciw` to change a word

**You're giving commands, not typing modified characters.**

The "cost" is pressing `i` to enter Insert mode when you want to type, and `Esc` to leave it. That's a small price for having your entire keyboard become a command palette.

### The Mental Model

Think of it this way:

```
Normal Mode = Remote Control
- You're controlling the editor
- Keys are buttons that do things
- This is where you spend most of your time

Insert Mode = Typewriter
- You're typing text
- Keys produce characters
- Enter only when you need to type, leave immediately after

Command Mode = Terminal
- You're giving the editor instructions
- Type a command, press Enter
- For things like save, quit, search-replace
```

When you opened Neovim, you started in Normal mode (remote control). That's why pressing keys didn't type letters - you were pressing remote control buttons.

## How to Exit Vim

Now this makes sense:

You're in Normal mode. You want to run the "quit" command. You need Command mode.

```
:q
```

- `:` enters Command mode (cursor jumps to bottom of screen)
- `q` is the quit command
- `Enter` executes it

The meme exists because people open Vim, start frantically typing (which does random things in Normal mode), and have no idea that `:` is how you give commands.

Now you know.

### The Quit Variations

**`:q`** - Quit. Works if you haven't changed anything.

**`:q!`** - Quit and discard changes. The `!` means "I'm sure, do it anyway."

**`:w`** - Write (save) the file. Doesn't quit.

**`:wq`** - Write and quit. The most common combo.

**`:x`** - Same as `:wq` but only writes if there are changes. Slightly more efficient, same result.

If you try `:q` after making changes, Vim refuses:

```
E37: No write since last change (add ! to override)
```

Vim is protecting you from losing work. Use `:wq` to save, or `:q!` to discard.

## Your First Real Interaction

Let's make this concrete. Do this now:

1. Open Neovim: `nvim`
2. You're in **Normal mode**. Press `i`.
3. Look at the bottom of the screen. It says `-- INSERT --`.
4. You're in **Insert mode**. Type: `Hello, Vim`
5. Press `Esc`. The `-- INSERT --` disappears.
6. You're back in **Normal mode**.
7. Type `:wq` and press Enter.

**Wait - you got an error.**

```
E32: No file name
```

This is Vim protecting you. You told it to **write** and quit, but you never specified a file. Write *where*? Vim doesn't know, so it refuses.

You have two options:

- `:w filename.txt` - Give it a name, then `:q` to quit
- `:q!` - Abandon the text entirely and quit

Try `:q!` now. The `!` means "I know I'm discarding unsaved work, do it anyway."

You're out. The text is gone. That's what `:q!` does - it's your escape hatch when you don't want to save.

Now let's do it properly:

```bash
nvim test.txt
```

Now repeat the steps. When you `:wq`, the file actually saves.

Check it:

```bash
cat test.txt
```

You should see `Hello, Vim`.

Delete the test file:

```bash
rm test.txt
```

## Create Your Config

Neovim looks for configuration at `~/.config/nvim/init.lua`. Create the directory and file:

```bash
mkdir -p ~/.config/nvim
touch ~/.config/nvim/init.lua
```

This is where we'll add settings throughout the tutorial. Right now it's empty - and that's intentional. We add things as we need them, so you understand every line.

Verify it exists:

```bash
ls ~/.config/nvim/
```

You should see `init.lua`.

## What Mode Am I In?

Until this becomes instinctive, look at the bottom left of your Neovim window:

| You see | You're in |
|---------|-----------|
| `-- INSERT --` | Insert mode (typing) |
| `-- VISUAL --` | Visual mode (selecting) |
| Nothing | Normal mode (commanding) |

When in doubt: press `Esc`. Multiple times if needed. You'll end up in Normal mode.

`Esc` is your "return to sanity" button. Lost? `Esc`. Confused? `Esc`. Something weird happening? `Esc`.

## Checkpoint

Run this:

```bash
echo "Neovim: $(nvim --version | head -1)"
echo "Python: $(python3 --version)"
echo "uv: $(uv --version 2>/dev/null || echo 'NOT INSTALLED')"
echo "ripgrep: $(rg --version | head -1 2>/dev/null || echo 'NOT INSTALLED')"
echo "fzf: $(fzf --version 2>/dev/null || echo 'NOT INSTALLED')"
echo "Config: $(test -f ~/.config/nvim/init.lua && echo 'exists' || echo 'MISSING')"
```

Everything should show versions or "exists".

Then verify you can:

1. Open Neovim (`nvim`)
2. Enter Insert mode (`i`)
3. Type some text
4. Return to Normal mode (`Esc`)
5. Quit without saving (`:q!`)

If you can do that without panic, you understand more about Vim than most people who've been "trying to learn" for years.

## Common Issues

**"nvim: command not found"**
Restart your terminal. If still broken, the install didn't add it to PATH.

**Version shows < 0.9**
You installed the ancient distro package. Remove it, use PPA/Homebrew.

**Config directory doesn't exist**
```bash
mkdir -p ~/.config/nvim && touch ~/.config/nvim/init.lua
```

**Pressed random keys in Normal mode, everything is messed up**
Press `Esc` repeatedly, then type `u` (undo) a few times. Or just `:q!` and start over.

## Key Takeaways

1. **Vim has modes** - Normal (commands), Insert (typing), Command (`:` commands)
2. **Normal mode is home** - You navigate and edit here, fingers on home row
3. **Insert mode is for typing** - Enter with `i`, leave with `Esc`
4. **`:q` to quit** - `:wq` to save-quit, `:q!` to force-quit
5. **When lost, press `Esc`** - Returns you to Normal mode

This modal system will feel awkward for about a day. Then it'll click. Then you'll wonder why every editor doesn't work this way.

---

[Next: Lesson 01 - Survival →](../01-survival/)
