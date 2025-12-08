# Lesson 02: Navigation

Time to build something real. And learn to move around code like you mean it.

## What You'll Learn

- Creating a Python project structure
- Word motions - move by words, not characters
- Line motions - jump to start/end of lines instantly
- File motions - teleport anywhere in a file
- Search - find anything in milliseconds
- Counts - multiply any motion

## The Project: tsk

We're building `tsk` - a terminal task manager. Simple, useful, and small enough to complete.

```
tsk add "Buy groceries"      # Add a task
tsk list                     # List all tasks
tsk done 1                   # Mark task complete
```

By the end of the tutorial, you'll have built this entirely in Neovim, then extended it with AI assistance.

But first, we need the skeleton. And to work on code, we need to move around it efficiently.

## Create the Project

Let's set up the project structure. Open a terminal (outside Neovim for now):

```bash
cd ~/projects  # or wherever you keep projects
mkdir tsk && cd tsk
```

Initialize with uv:

```bash
uv init --lib --name tsk
uv add typer
```

That's it. `uv init --lib` creates the proper src layout. `uv add typer` installs our CLI framework.

Your structure now looks like:

```
tsk/
├── pyproject.toml
├── src/
│   └── tsk/
│       └── __init__.py
└── uv.lock
```

One more thing - we need to tell Python how to run `tsk` as a command. Open `pyproject.toml` and add the scripts section:

```bash
nvim pyproject.toml
```

Find the `[project]` section and add this line after `dependencies`:

```toml
[project.scripts]
tsk = "tsk.main:app"
```

Save and quit (`:wq`). This tells Python: "when someone runs `tsk`, execute the `app` function from `tsk.main`."

Now open the project in Neovim:

```bash
nvim src/tsk/main.py
```

You're staring at an empty file. Time to write some code - and learn to navigate it.

## Writing the Skeleton

Press `i` to enter Insert mode and type this:

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


@app.command()
def done(task_id: int):
    """Mark a task as complete."""
    print(f"TODO: Mark task #{task_id} done")


if __name__ == "__main__":
    app()
```

Press `jk` (or Escape) to return to Normal mode. Save with `:w`.

**You just wrote your first code in Neovim.** Now let's learn to move around it properly.

## The Problem With hjkl

In lesson 01, we learned hjkl for movement. And I told you: "hjkl is for fine movement. For everything else, there's a faster way."

Look at the file you just wrote. It's ~25 lines. If you want to jump from the `add` function to the `done` function, are you going to press `j` fifteen times?

No. There's a better way.

## Word Motions: Your New Best Friend

Code is made of words. Variables, functions, keywords - all words. Moving by words is almost always what you want.

| Key | Motion |
|-----|--------|
| `w` | Next word (start) |
| `b` | Back word (start) |
| `e` | End of word |

Try it now. Go to line 1 (`gg`) and press `w` repeatedly. Watch the cursor hop: `import` → `typer` → next line...

**This is the motion you'll use most.**

### word vs WORD

Put your cursor on line 8: `def add(task: str):`

Press `w` repeatedly. Notice it stops at: `def`, `add`, `task`, `str`. That's four stops because `(`, `:` are word boundaries.

Now go back (`gg`) and try `W` (capital). It only stops at whitespace. Fewer stops, faster movement.

```
def add(task: str):
^   ^              ^
W   W              W    -- only stops at spaces

def add(task: str):
^   ^   ^     ^
w   w   w     w         -- stops at punctuation too
```

**When to use which:**
- `w` for precise navigation
- `W` for blasting through code quickly

## Line Motions: Beginning and End

| Key | Motion |
|-----|--------|
| `0` | Beginning of line (column 0) |
| `^` | First non-whitespace character |
| `$` | End of line |

Go to line 10 (the `print` inside `add`). It's indented.

- Press `0` - cursor goes to column 0 (the whitespace)
- Press `^` - cursor goes to `p` in `print` (first real character)
- Press `$` - cursor goes to the closing `)`

In code, `^` is almost always what you want. The indentation doesn't matter.

## File Motions: Teleportation

| Key | Motion |
|-----|--------|
| `gg` | Go to first line |
| `G` | Go to last line |
| `{number}G` | Go to line {number} |
| `Ctrl-d` | Half page down |
| `Ctrl-u` | Half page up |
| `{` | Previous blank line |
| `}` | Next blank line |

### Try It

1. Press `gg` - you're at line 1
2. Press `G` - you're at the last line
3. Press `8G` - you're at line 8 (the `add` function)
4. Press `}` - jump to the next blank line
5. Press `}` again - next section
6. Press `{` - go back

The `{` and `}` motions are perfect for jumping between functions. Our code has blank lines separating each function - that's where these motions land.

### Relative Line Numbers Pay Off

Look at the line numbers on the left. The current line shows the absolute number; others show the relative distance.

If `done` is 7 lines down from your cursor, you see `7` next to it. Type `7j` to get there.

No mental math. Just look and type.

## Search: The Killer Feature

| Key | Action |
|-----|--------|
| `/pattern` | Search forward |
| `?pattern` | Search backward |
| `n` | Next match |
| `N` | Previous match |
| `*` | Search word under cursor |

### Find the TODOs

We left `TODO` comments in our code. Let's find them:

```
/TODO<Enter>
```

Cursor jumps to the first `TODO`. Press `n` to go to the next one. Press `n` again for the third.

Press `N` to go backwards.

### The Star Search

Put your cursor on `task` (any occurrence). Press `*`.

Vim searches for the whole word `task`. Press `n` to cycle through all occurrences. This is how you find all uses of a variable.

**This is navigation gold.** You don't scroll looking for something - you search for it.

## Counts: The Multiplier

Any motion can be multiplied:

| Command | Effect |
|---------|--------|
| `3w` | Move 3 words forward |
| `5j` | Move 5 lines down |
| `2}` | Jump 2 blank lines forward |

You already used this with `7j`. It works everywhere:
- `3b` - back 3 words
- `2Ctrl-d` - down 2 half-pages

In lesson 03, this becomes powerful: `d3w` = delete 3 words. Same pattern.

## Config Additions

Open your config:

```bash
nvim ~/.config/nvim/init.lua
```

Add these lines:

```lua
vim.opt.scrolloff = 8
vim.opt.ignorecase = true
vim.opt.smartcase = true
```

**What they do:**

- `scrolloff = 8`: Keep 8 lines visible above/below cursor when scrolling
- `ignorecase`: Searches ignore case by default
- `smartcase`: If search contains uppercase, become case-sensitive

Save and restart Neovim.

## Checkpoint

You should now be able to:

1. **Navigate by words** - `w`, `b`, `e`
2. **Jump to line boundaries** - `0`, `^`, `$`
3. **Teleport in files** - `gg`, `G`, `{number}G`
4. **Jump by sections** - `{`, `}`
5. **Search instantly** - `/pattern`, `n`, `N`, `*`
6. **Use counts** - `3w`, `5j`

Verify your tsk project works:

```bash
cd ~/projects/tsk
uv run tsk --help
uv run tsk add "Test task"
uv run tsk list
```

You should see the TODO messages. We'll implement the real logic in lesson 03.

## Common Issues

**"Search highlights stay on screen"**

Press `Esc` or type `:noh` to clear highlights.

**"Relative numbers are confusing"**

Give it time. Once you use `7j` a few times, it clicks.

**"`uv run` doesn't work"**

Make sure you ran `uv sync` in the project directory first.

**"The project structure looks different"**

Verify:
```
tsk/
├── pyproject.toml
├── src/
│   └── tsk/
│       ├── __init__.py
│       └── main.py
└── uv.lock (created by uv sync)
```

## Key Takeaways

1. **We started building tsk** - This isn't practice on fake files. This is your project.

2. **Words are your atoms** - `w` and `b` are the motions you'll use most.

3. **Search, don't scroll** - `/pattern` is almost always faster than navigating manually.

4. **`*` is magic** - Cursor on a word, press `*`, see all occurrences.

5. **Counts multiply everything** - `{count}{motion}` works everywhere.

6. **There's always a faster way** - If you're pressing the same key repeatedly, you're doing it wrong.

You've written real code and learned to navigate it. Next lesson, we implement the actual task logic - and learn Vim's editing grammar that makes writing code feel like speaking commands.

---

[Next: Lesson 03 - Editing Grammar →](../03-editing-grammar/)
