# Lesson 03: Editing Grammar

This is the lesson where Vim stops being weird and starts being powerful.

## What You'll Learn

- The verb + noun grammar that makes Vim composable
- Operators: `d` (delete), `c` (change), `y` (yank)
- Text objects: `iw`, `i"`, `i{` - the precision tools
- The dot command: repeat anything with `.`
- Building real functionality in tsk

## The Grammar Revelation

Here's the secret that Vim tutorials bury under 50 pages of keybindings:

**Vim is a language.**

Every editing command follows a grammar:

```
[count] operator [count] motion
```

Or more simply:

```
verb + noun = action
```

Once you learn a few verbs and a few nouns, you can combine them freely:

| Verb | Meaning |
|------|---------|
| `d` | delete |
| `c` | change (delete + enter insert mode) |
| `y` | yank (copy) |
| `>` | indent right |
| `<` | indent left |

| Noun (Motion) | Meaning |
|---------------|---------|
| `w` | word |
| `b` | back word |
| `$` | to end of line |
| `0` | to start of line |
| `}` | to next blank line |
| `G` | to end of file |

**Now combine them:**

| Command | Translation | Result |
|---------|-------------|--------|
| `dw` | delete word | Deletes from cursor to start of next word |
| `d$` | delete to end | Deletes from cursor to end of line |
| `d}` | delete to blank | Deletes to next blank line |
| `cw` | change word | Deletes word, enters insert mode |
| `y$` | yank to end | Copies from cursor to end of line |

**This is the superpower.** Learn 5 verbs and 10 nouns, get 50 commands for free.

## Let's See It Work

Open your tsk project:

```bash
cd ~/projects/tsk
nvim src/tsk/main.py
```

Your file has the skeleton from lesson 02. Time to make it real.

### Delete: The `d` Verb

Find the `add` function. Put your cursor on the `p` in `print`:

```python
def add(task: str):
    """Add a new task."""
    print(f"TODO: Add task: {task}")
```

Try these:

1. `dw` - delete from cursor to next word boundary
2. Press `u` to undo
3. `d$` - delete from cursor to end of line
4. Press `u` to undo
5. `dd` - delete entire line (special case: doubled operator = whole line)
6. Press `u` to undo

**The pattern:** `d` + motion = delete that motion's range.

### Change: The `c` Verb

`c` is `d` that drops you into insert mode. It's for replacing, not just removing.

Put cursor on `TODO` in the print statement.

1. `cw` - deletes `TODO`, enters insert mode
2. Type: `Added`
3. Press `jk` to exit insert mode

You just changed a word. But there's a better way...

## Text Objects: Precision Editing

Motions are great, but they depend on cursor position. Text objects don't care where your cursor is within the object.

| Text Object | Meaning |
|-------------|---------|
| `iw` | inner word (just the word) |
| `aw` | a word (word + surrounding space) |
| `i"` | inner quotes (content between "") |
| `a"` | a quoted string (including the quotes) |
| `i(` or `ib` | inner parentheses |
| `a(` or `ab` | around parentheses |
| `i{` or `iB` | inner braces |
| `a{` or `aB` | around braces |

### The Magic of `ci"`

This is the command you'll use constantly.

Find this line in your `add` function:

```python
    print(f"TODO: Add task: {task}")
```

Put your cursor anywhere inside the quotes. Doesn't matter where - on `TODO`, on `Add`, on the `{`.

Type: `ci"`

What happens:
1. Everything inside the quotes disappears
2. You're in insert mode
3. The quotes are still there

Now type: `✓ Added task #{task.id}: {task.text}`

Press `jk` to exit.

**That's it.** `ci"` = "change inside quotes". You didn't need to navigate to the start of the string. You just said "change what's in these quotes" and Vim figured it out.

### Inner vs Around

The `i` vs `a` distinction matters:

- `ci"` changes the content, keeps the quotes
- `ca"` changes content AND quotes (you'll retype them)
- `diw` deletes the word only
- `daw` deletes the word and the space after it

Try `daw` on a word in the middle of a line. Then undo and try `diw`. See the difference?

## Building the Task Class

Time to write real code. We need:

1. A `Status` enum
2. A `Task` dataclass
3. Storage for tasks
4. Working `add` and `list` commands

### Add the Imports

Go to line 1 (`gg`). We need more imports.

Your current line 1:
```python
import typer
```

Put cursor at end of line (`$`), press `a` to append, hit Enter, and type:

```python
from dataclasses import dataclass
from enum import Enum
```

Press `jk` to exit insert mode.

### Add the Storage

Find the line `app = typer.Typer(...)`. Go to end of that line and add two blank lines below:

Position cursor on the `app = typer...` line, then:

```
o
```

That's lowercase `o` - it opens a new line below and enters insert mode.

Add this code:

```python

# In-memory storage (persistence comes in lesson 04)
tasks: list["Task"] = []
next_id: int = 1
```

Press `jk` when done.

### Create the Status Enum

We need this before the Task class. After your storage variables, type:

```
o
```

Then add:

```python

class Status(Enum):
    TODO = "todo"
    DONE = "done"
```

### Create the Task Dataclass

One more `o` after Status:

```python

@dataclass
class Task:
    id: int
    text: str
    status: Status = Status.TODO
```

### Practice: Fix the add Function

Now use what you learned to fix the `add` function.

Current state:
```python
@app.command()
def add(task: str):
    """Add a new task."""
    print(f"TODO: Add task: {task}")
```

Target state:
```python
@app.command()
def add(task: str):
    """Add a new task."""
    global next_id
    t = Task(id=next_id, text=task)
    tasks.append(t)
    next_id += 1
    print(f"✓ Added task #{t.id}: {t.text}")
```

Here's how to do it efficiently:

1. Navigate to the `print` line inside `add` (use `/TODO` then `n` to find it)
2. `cc` - change entire line (deletes line content, enters insert)
3. Type: `global next_id`
4. `jk` to exit, then `o` to open line below
5. Type the remaining lines

Or even faster - delete the print and write fresh:

1. `dd` on the print line
2. `O` (capital O - opens line ABOVE)
3. Type all four new lines

### Practice: Fix the list Function

Current:
```python
@app.command("list")
def list_tasks():
    """List all tasks."""
    print("TODO: List tasks")
```

Target:
```python
@app.command("list")
def list_tasks():
    """List all tasks."""
    if not tasks:
        print("No tasks")
        return
    for t in tasks:
        status = "✓" if t.status == Status.DONE else "○"
        print(f"  {status} [{t.id}] {t.text}")
```

Do it yourself. Use `cc` to change the print line, `o` to add lines below.

## The Dot Command: Repeat Anything

The `.` key repeats your last change. This is massive.

Say you want to change multiple occurrences of `task` to `item`. You could search and replace, but let's use the dot:

1. Find `task` with `/task<Enter>`
2. `ciw` - change inner word
3. Type `item`
4. `jk` to exit insert mode
5. `n` - next occurrence
6. `.` - repeat the change

That's it. `n` to find, `.` to change. Repeat until done.

If a match shouldn't change, just `n` to skip it.

## Operator + Count + Motion

Remember counts from lesson 02? They work with operators too:

| Command | Effect |
|---------|--------|
| `d2w` | Delete 2 words |
| `c3w` | Change 3 words |
| `y4j` | Yank 4 lines down |
| `>2}` | Indent 2 paragraphs |
| `d/pattern` | Delete until pattern |

The `d/pattern` trick is underrated. Want to delete everything from cursor until "def"? Type `d/def<Enter>`.

## Visual Mode: When Grammar Isn't Enough

Sometimes you want to see what you're selecting before acting:

| Key | Mode |
|-----|------|
| `v` | Visual (character) |
| `V` | Visual Line |
| `Ctrl-v` | Visual Block |

Enter visual mode, move to select, then apply an operator:

1. `V` - enter visual line mode
2. `3j` - select 3 more lines down
3. `d` - delete all selected lines

Or:

1. `v` - visual mode
2. `i"` - select inner quotes
3. `y` - yank

Visual mode is training wheels. As you get faster, you'll skip it and use operators directly. But it's great for learning and for complex selections.

## Your Complete main.py

After all edits, your file should look like:

```python
import typer
from dataclasses import dataclass
from enum import Enum

app = typer.Typer(help="Terminal task manager")

# In-memory storage (persistence comes in lesson 04)
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


@app.command()
def done(task_id: int):
    """Mark a task as complete."""
    print(f"TODO: Mark task #{task_id} done")


if __name__ == "__main__":
    app()
```

Save with `:w`.

## Test It

```bash
uv run tsk add "Learn Vim grammar"
uv run tsk add "Build tsk"
uv run tsk list
```

Expected output:
```
✓ Added task #1: Learn Vim grammar
✓ Added task #2: Build tsk

  ○ [1] Learn Vim grammar
  ○ [2] Build tsk
```

**The tasks won't persist between runs** - that's fine. We're storing in memory. Persistence comes in lesson 04.

But look: you wrote real, working code. Using Vim's editing grammar. The commands are starting to feel natural.

## Quick Reference

### Operators (Verbs)

| Key | Action |
|-----|--------|
| `d` | Delete |
| `c` | Change (delete + insert mode) |
| `y` | Yank (copy) |
| `>` | Indent right |
| `<` | Indent left |
| `=` | Auto-indent |
| `gu` | Lowercase |
| `gU` | Uppercase |

### Text Objects (Nouns)

| Object | Description |
|--------|-------------|
| `iw` / `aw` | Inner/around word |
| `iW` / `aW` | Inner/around WORD |
| `is` / `as` | Inner/around sentence |
| `ip` / `ap` | Inner/around paragraph |
| `i"` / `a"` | Inner/around double quotes |
| `i'` / `a'` | Inner/around single quotes |
| `i)` / `a)` | Inner/around parentheses |
| `i]` / `a]` | Inner/around brackets |
| `i}` / `a}` | Inner/around braces |
| `it` / `at` | Inner/around HTML/XML tag |

### Power Combos

| Command | What It Does |
|---------|--------------|
| `ciw` | Change word (anywhere in word) |
| `ci"` | Change inside quotes |
| `ci(` | Change inside parentheses |
| `da"` | Delete quoted string including quotes |
| `yap` | Yank paragraph |
| `>i{` | Indent inside braces |
| `=G` | Auto-indent to end of file |

## Checkpoint

You should now be able to:

1. **Use operators** - `d`, `c`, `y` with motions
2. **Use text objects** - `iw`, `i"`, `i{` for precision
3. **Repeat with dot** - `.` after any change
4. **Double operators** - `dd`, `cc`, `yy` for whole lines
5. **Run tsk** - Add and list tasks work (in-memory)

Test the grammar by doing the exercises. The more you use it, the more automatic it becomes.

## Common Issues

**"Changed the wrong thing"**

`u` is unlimited undo. Keep pressing it. `Ctrl-r` is redo.

**"ci" didn't work"**

Make sure your cursor is actually inside the quotes. If you're on the quote character itself, it might not work as expected.

**"Tasks disappear when I run again"**

That's expected. We're storing in memory. Exit = gone. Persistence is lesson 04.

**"Visual mode is confusing"**

Skip it for now. You can do everything with operators + text objects. Visual mode is optional.

## The Insight

You now understand why Vim users are fast.

It's not memorizing 200 keybindings. It's learning a small grammar that composes infinitely. `d` + anything = delete that thing. `c` + anything = change that thing.

Five minutes from now, you'll discover `ci[` deletes inside brackets. You didn't learn it - you derived it from the grammar.

That's the power. That's why people stick with Vim for decades.

Next lesson, we split this file into modules and learn to work with multiple files. Your tsk project is growing.

---

[Next: Lesson 04 - Files and Buffers →](../04-files-and-buffers/)
