# Lesson 01: Survival

Your first real config. Making Neovim usable.

## What You'll Learn

- Why raw Neovim is deliberately minimal
- Your first config file (and what each line does)
- The leader key concept - your personal command prefix
- Why `jk` beats reaching for Escape
- Basic movement that keeps your hands on home row

## The Problem With Stock Neovim

Open Neovim right now:

```bash
nvim
```

Notice what's missing:

- No line numbers
- No syntax highlighting for most languages
- Tab key inserts actual tab characters (not spaces)
- No visual feedback about where you are in the file
- Escape key is far away from home row

This isn't an oversight. Vim's philosophy is "start minimal, add what you need." The config you build is *yours* - you understand every line because you added it for a reason.

Most tutorials dump a 500-line config on you and say "trust me." You end up with features you don't understand, keybindings that conflict, and no idea how to fix problems.

We're doing it differently. Every line we add solves a specific problem you'll encounter.

## Your First Config

Open your config file:

```bash
nvim ~/.config/nvim/init.lua
```

The file is empty (we created it in lesson 00). Time to add some essentials.

### Understanding Lua Config Syntax

Neovim uses Lua for configuration. The syntax is simple:

```lua
vim.opt.setting = value      -- Set an option
vim.g.variable = value       -- Set a global variable
vim.keymap.set(mode, key, action)  -- Create a keybinding
```

That's 90% of what you need to know. Let's use it.

### Line Numbers

Press `i` to enter Insert mode, then type:

```lua
vim.opt.number = true
vim.opt.relativenumber = true
```

Press `Esc` to return to Normal mode, then `:w` to save.

Now restart Neovim (`:q` then `nvim ~/.config/nvim/init.lua`) and look at the left side.

You see line numbers. But they're weird - the current line shows the absolute number, and other lines show *relative* distance from your cursor.

**Why relative numbers?**

In Vim, you'll constantly use commands like "delete 5 lines" (`5dd`) or "move down 7 lines" (`7j`). Relative numbers let you *see* those numbers instead of doing mental math.

Your cursor is on line 47. You want to jump to line 52. With absolute numbers, you'd calculate: 52 - 47 = 5, then press `5j`.

With relative numbers, you just *look* at line 52 and it says "5". Press `5j`. Done.

This seems minor until you realize how often you navigate by "N lines up/down." The mental math adds up. Relative numbers eliminate it.

### Tabs and Indentation

Add these lines:

```lua
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
```

Save (`:w`).

**What each one does:**

- `tabstop = 4` - A tab character displays as 4 spaces wide
- `shiftwidth = 4` - Auto-indent and shift commands (`>>`, `<<`) use 4 spaces
- `expandtab = true` - Pressing Tab inserts spaces, not a tab character
- `smartindent = true` - Neovim guesses the right indentation when you start a new line

**Why spaces over tabs?**

Religious war territory, but the practical answer: spaces render identically everywhere. Tabs render differently depending on viewer settings. Python specifically requires consistent indentation - mixing tabs and spaces causes bugs.

If your project uses tabs, change `expandtab` to `false`. The point is: you're in control.

### Visual Polish

Add:

```lua
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
```

- `termguicolors` - Use full 24-bit color instead of the limited terminal palette. Makes themes look right.
- `signcolumn = "yes"` - Always show the sign column (left gutter). This prevents the editor from "jumping" when diagnostics or git signs appear.

### System Clipboard

Add:

```lua
vim.opt.clipboard = "unnamedplus"
```

This connects Vim's yank/paste to your system clipboard. When you copy text in Vim with `y`, you can paste it in Chrome. When you copy in Chrome, you can paste in Vim with `p`.

Without this, Vim maintains its own separate clipboard (registers), which is powerful but confusing when you're starting. We'll explore registers later if you want that power.

**WSL users:** You need a clipboard provider. Install xclip:

```bash
sudo apt install xclip
```

Without this, you'll get clipboard errors when pasting.

## The Leader Key

Add this line:

```lua
vim.g.mapleader = " "
```

**What's a leader key?**

The leader key is a prefix for your custom keybindings. When you press it, Vim waits for the next key(s) to determine what command to run.

We're setting it to Space. Why?

1. **Space is the biggest key** - easy to hit
2. **It's under your thumbs** - no finger stretching
3. **It does nothing useful in Normal mode** - safe to repurpose

With leader set to Space, you can create keybindings like:
- `Space f f` → Find files
- `Space e` → File explorer
- `Space w` → Save file

The space at the start is the "I'm about to give a custom command" signal. This keeps your custom bindings from conflicting with Vim's built-in keys.

**You won't use this yet** - we'll add leader keybindings when we add plugins. But setting it now means all future keybindings will be consistent.

## The jk Escape

Add this line:

```lua
vim.keymap.set("i", "jk", "<Esc>")
```

This maps typing `jk` in Insert mode to pressing Escape.

**Why?**

Look at your keyboard. Where's the Escape key? Top left corner. Your fingers leave home row every single time you exit Insert mode.

In Vim, you exit Insert mode *constantly*. The mode philosophy is "enter Insert when you need to type, leave immediately after." That's a lot of Escape pressing.

The `jk` sequence:
1. Both keys are on home row
2. The sequence is fast to type
3. The letters "jk" almost never appear consecutively in real code or text

This is your first *custom* keybinding - you're making Vim work how *you* want.

**Note:** You can still use Escape. This just adds an alternative. Many Vim users use `jj` instead. Some use `Ctrl-[` (which is Escape in terminal terms). Pick what feels right.

## The Complete Config So Far

Your `~/.config/nvim/init.lua` should now contain:

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

That's 12 lines. Every line solves a real problem. You understand all of them.

Save and restart Neovim to apply changes.

## Basic Movement: hjkl

You're in Normal mode. Time to move around.

The arrow keys work. But they're far from home row, and using them marks you as a Vim tourist.

The home row alternative:

| Key | Direction |
|-----|-----------|
| `h` | Left |
| `j` | Down |
| `k` | Up |
| `l` | Right |

**Why hjkl?**

When Bill Joy created vi in 1976, his terminal didn't have arrow keys. The ADM-3A terminal had arrows printed on the hjkl keys.

That's the historical reason. The practical reason: **your fingers never leave home row.**

On a QWERTY keyboard, your right hand rests on jkl; (or nearby). Moving with hjkl means moving without moving your hands.

### The Mental Shift

This feels wrong at first. You've spent years using arrow keys. Your brain has to rewire.

Here's the trick: **h and l make sense** (left and right, horizontally adjacent). **j and k are the confusing ones** (which is up, which is down?).

Memory aids that work for different people:
- `j` looks like a down arrow (the hook points down)
- `j`ump down
- `k`limb up (k for klimb)
- Just practice until it's muscle memory (the real answer)

### Try It Now

Open any file:

```bash
nvim ~/.config/nvim/init.lua
```

Now navigate using only hjkl:
1. Press `j` repeatedly - cursor moves down
2. Press `k` repeatedly - cursor moves up
3. Press `l` repeatedly - cursor moves right
4. Press `h` repeatedly - cursor moves left

Do this for 30 seconds. It'll feel slow. That's fine.

### When hjkl Is Wrong

Here's a secret: **experienced Vim users rarely hold hjkl to move large distances.**

If you need to move 20 lines down, you don't press `j` 20 times. You:
- Use `20j` (move 20 lines down)
- Use `Ctrl-d` (half page down)
- Use `/searchterm` (jump to specific text)
- Use `{` or `}` (jump by paragraph)

We'll cover all of these in lesson 02. The point: hjkl is for *fine* movement. A few lines up or down. A few characters left or right.

For everything else, there's a faster way. Vim rewards you for learning those faster ways.

## Editing Basics

You know `i` enters Insert mode. There are actually several ways to enter Insert mode, each putting your cursor in a different position:

| Key | Where cursor goes | Use case |
|-----|-------------------|----------|
| `i` | Before current character | Insert text before cursor |
| `a` | After current character | Append text after cursor |
| `I` | Beginning of line | Add text at line start |
| `A` | End of line | Add text at line end |
| `o` | New line below | Start a new line and type |
| `O` | New line above | Insert a line above and type |

**Why so many?**

Because "enter Insert mode and start typing" is context-dependent. If your cursor is in the middle of a line and you want to add text at the end, `A` gets you there in one keystroke instead of moving to the end then pressing `i`.

This is a pattern in Vim: **common operations get single-key shortcuts.**

### Try It

Open your config file and try each:

1. Put cursor in the middle of a line
2. Press `i`, type "test", press `jk` (or Esc)
3. Press `u` to undo
4. Press `a`, type "test", press `jk`
5. Press `u` to undo
6. Press `A`, type "test", press `jk` - notice cursor jumped to end of line
7. Press `u` to undo
8. Press `o`, type "new line", press `jk` - notice new line was created below
9. Press `u` to undo

The `u` key is undo. Essential. Vim has unlimited undo history by default.

## Checkpoint

You should now be able to:

1. **Edit your config** - Open `~/.config/nvim/init.lua`, make changes, save
2. **Navigate with hjkl** - Move around without arrow keys (even if it feels slow)
3. **Exit Insert mode with jk** - Faster than reaching for Escape
4. **Enter Insert mode different ways** - `i`, `a`, `A`, `o` depending on where you want to type
5. **Undo mistakes** - Press `u` when you mess up

Run this to verify your config has all the settings:

```bash
nvim --headless -c 'echo "number: " . &number . " | relativenumber: " . &relativenumber . " | tabstop: " . &tabstop . " | mapleader: [" . g:mapleader . "]"' -c 'qa!'
```

Should output: `number: 1 | relativenumber: 1 | tabstop: 4 | mapleader: [ ]`

(The mapleader shows as a blank space because it *is* a space.)

## Common Issues

**"jk types jk instead of escaping"**

You're in Normal mode, not Insert mode. `jk` only works to *escape from* Insert mode.

**"Line numbers disappeared after restart"**

You didn't save the config. Open `~/.config/nvim/init.lua` and check if your lines are there. Use `:w` to save.

**"Relative numbers are confusing"**

Give it a day. Once you use `5j` or `3k` a few times and see how relative numbers help, it clicks.

**"I keep using arrow keys"**

Normal. It takes a few days to break the habit. Some people remap arrow keys to nothing to force themselves:

```lua
-- Nuclear option: disable arrow keys
vim.keymap.set("n", "<Up>", "<Nop>")
vim.keymap.set("n", "<Down>", "<Nop>")
vim.keymap.set("n", "<Left>", "<Nop>")
vim.keymap.set("n", "<Right>", "<Nop>")
```

Only do this if you want to suffer. It works, but it's painful.

## Key Takeaways

1. **Config grows with you** - We added 12 lines. Each one solves a problem you'll actually encounter.

2. **Leader key is your namespace** - Space + something = your custom command. We'll use this heavily later.

3. **jk > Escape** - Home row escape is faster. Small optimization, big cumulative effect.

4. **hjkl is for fine movement** - Use it for small adjustments. Bigger movements have better tools (coming in lesson 02).

5. **Multiple Insert modes** - `i`, `a`, `A`, `o`, `O` each solve a different "where do I want to start typing" problem.

6. **u for undo** - Mess up? `u`. Mess up again? `u`. Vim forgives.

Your config is now usable. Not fancy, but functional. Every future addition will build on this foundation.

---

[Next: Lesson 02 - Navigation →](../02-navigation/)

