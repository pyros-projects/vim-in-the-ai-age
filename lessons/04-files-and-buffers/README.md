# Lesson 04: Files and Buffers

Your `main.py` is getting long. Time to split it up — and learn to work with multiple files like you mean it.

## What You'll Learn

- Buffers: files loaded in memory
- Splits: viewing multiple files at once
- Window navigation: jumping between splits instantly
- Refactoring across files
- Adding persistence to tsk

## The Problem

Open your tsk project:

```bash
cd ~/projects/tsk
nvim src/tsk/main.py
```

Look at this file. It's got:
- Imports
- Global variables
- An Enum
- A dataclass
- Three command functions
- A main block

That's too much for one file. The `Task` class and storage logic should live somewhere else. The CLI commands should stay here.

Time to split.

## Buffers: The Mental Model

In Vim, a **buffer** is a file loaded into memory. It might be visible. It might not.

A **window** is a viewport showing a buffer.

You can have 10 buffers open but only 2 visible in splits. The others are still there, ready to switch to.

```
┌─────────────────────────────────────────┐
│ Vim                                     │
│  ┌─────────────┐  ┌─────────────┐       │
│  │ Window 1    │  │ Window 2    │       │
│  │ (main.py)   │  │ (models.py) │       │
│  │             │  │             │       │
│  └─────────────┘  └─────────────┘       │
│                                         │
│  Hidden buffers: __init__.py, test.py   │
└─────────────────────────────────────────┘
```

## Creating a Split

You're in `main.py`. Let's open `models.py` in a vertical split.

```
:vs src/tsk/models.py
```

Two things happen:
1. The window splits vertically
2. `models.py` opens (created if it doesn't exist)

You now have two windows. Your cursor is in the new one (models.py).

### Split Commands

| Command | Effect |
|---------|--------|
| `:vs file` | Vertical split, open file |
| `:sp file` | Horizontal split, open file |
| `:vs` | Vertical split, same file |
| `:sp` | Horizontal split, same file |
| `Ctrl-w v` | Vertical split (same as `:vs`) |
| `Ctrl-w s` | Horizontal split (same as `:sp`) |

## Window Navigation

Your cursor is in models.py. How do you get back to main.py?

```
Ctrl-w h    " Move to window on the left
Ctrl-w l    " Move to window on the right
Ctrl-w j    " Move to window below
Ctrl-w k    " Move to window above
```

Try it: `Ctrl-w h` moves you to main.py. `Ctrl-w l` moves you back.

### That's Too Many Keystrokes

`Ctrl-w h` is three keys. Let's fix that.

Close Neovim (`:qa`) and open your config:

```bash
nvim ~/.config/nvim/init.lua
```

Add these lines:

```lua
-- Easier window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
```

Save and restart Neovim. Now it's just `Ctrl-h` to go left, `Ctrl-l` to go right.

## Window Management

| Command | Effect |
|---------|--------|
| `Ctrl-w q` | Close current window |
| `Ctrl-w o` | Close all OTHER windows (current stays) |
| `Ctrl-w =` | Make all windows equal size |
| `Ctrl-w >` | Increase width |
| `Ctrl-w <` | Decrease width |
| `Ctrl-w +` | Increase height |
| `Ctrl-w -` | Decrease height |

### Quick Resize

Want the left window bigger? Go to it (`Ctrl-h`) and:

```
30Ctrl-w >    " 30 columns wider
```

Or use `Ctrl-w =` to reset them equal.

## Buffer Commands

Splits show buffers. But you can have more buffers than windows.

| Command | Effect |
|---------|--------|
| `:e file` | Edit file (opens in current window) |
| `:ls` | List all buffers |
| `:b name` | Switch to buffer (partial name works) |
| `:bn` | Next buffer |
| `:bp` | Previous buffer |
| `:bd` | Close buffer (not window) |

### Try It

```
:e src/tsk/__init__.py
```

Now you have three buffers. Check with `:ls`:

```
  1  h   "src/tsk/main.py"          line 1
  2  h   "src/tsk/models.py"        line 1
  3 %a   "src/tsk/__init__.py"      line 1
```

The `%` marks the current buffer. `h` means hidden (loaded but not visible).

Switch back to main.py:

```
:b main
```

Vim matches partial names. `:b mod` would switch to models.py.

## Now Let's Refactor

Time to split your code properly. Here's the plan:

1. Create `models.py` with Task, Status, and TaskStore
2. Slim down `main.py` to just CLI commands
3. Add JSON persistence

### Set Up the Splits

```bash
cd ~/projects/tsk
nvim src/tsk/main.py
```

Open models.py in a split:

```
:vs src/tsk/models.py
```

You should see main.py on the left, empty models.py on the right.

### Build models.py

Focus on models.py (`Ctrl-l` or `Ctrl-w l`). Type this out — use the Vim grammar you learned:

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

    def list_all(self) -> list[Task]:
        return self.tasks
```

That's a lot of typing. Good practice for the grammar. Use `o` to open lines, `ciw` to fix typos, `dd` to delete mistakes.

Save it: `:w`

### Refactor main.py

Now switch to main.py (`Ctrl-h`).

We need to gut this file. Delete almost everything and replace it with a thin CLI layer.

Here's the target:

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
        icon = "✓" if t.status == Status.DONE else "○"
        print(f"  {icon} [{t.id}] {t.text}")


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


if __name__ == "__main__":
    app()
```

### The Fast Way to Replace

Instead of editing line by line, let's nuke and rebuild:

1. Select everything: `ggVG` (go to top, visual line, go to bottom)
2. Delete: `d`
3. Enter insert mode: `i`
4. Type (or paste) the new code
5. Exit: `jk`
6. Save: `:w`

Or if you want practice:

1. Keep the imports area, delete the rest: Go to line 3, then `dG`
2. Fix imports: Change the import lines using `cc`
3. Build functions one by one using `o`

### Verify Both Files

Switch between them (`Ctrl-h`, `Ctrl-l`) and verify:

- `models.py`: Has Status, Task, TaskStore (~80 lines)
- `main.py`: Has CLI commands only (~50 lines)

Save both: `:wa` (write all)

## Test the Persistence

```bash
uv run tsk add "First persistent task"
uv run tsk add "Second task"
uv run tsk list
```

Output:
```
✓ Added task #1: First persistent task
✓ Added task #2: Second task

  ○ [1] First persistent task
  ○ [2] Second task
```

Now the magic — close your terminal entirely. Open a new one:

```bash
cd ~/projects/tsk
uv run tsk list
```

```
  ○ [1] First persistent task
  ○ [2] Second task
```

**They're still there.** Check the file:

```bash
cat ~/.tsk/tasks.json
```

```json
[
  {
    "id": 1,
    "text": "First persistent task",
    "status": "todo",
    "created": "2024-..."
  },
  ...
]
```

Real persistence. Your task manager actually works now.

## Test All Commands

```bash
uv run tsk done 1
uv run tsk list
uv run tsk rm 2
uv run tsk list
```

```
✓ Completed: First persistent task

  ✓ [1] First persistent task
  ○ [2] Second task

Deleted task #2

  ✓ [1] First persistent task
```

Everything works. Multi-file project. Persistent storage. Real software.

## Quick Reference: Window Commands

| Command | Effect |
|---------|--------|
| `:vs file` | Vertical split |
| `:sp file` | Horizontal split |
| `Ctrl-h/j/k/l` | Navigate windows (after config) |
| `Ctrl-w q` | Close window |
| `Ctrl-w o` | Close other windows |
| `Ctrl-w =` | Equal size |
| `Ctrl-w >/<` | Wider/narrower |
| `Ctrl-w +/-` | Taller/shorter |

## Quick Reference: Buffer Commands

| Command | Effect |
|---------|--------|
| `:e file` | Open file |
| `:ls` | List buffers |
| `:b name` | Switch to buffer |
| `:bn` / `:bp` | Next/previous buffer |
| `:bd` | Close buffer |
| `:wa` | Write all buffers |
| `:qa` | Quit all |

## Config Additions

Your `init.lua` should now include:

```lua
-- Easier window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
```

## Checkpoint

You should now be able to:

1. **Create splits** — `:vs`, `:sp`
2. **Navigate windows** — `Ctrl-h/j/k/l`
3. **Manage buffers** — `:ls`, `:b`, `:bn`, `:bp`
4. **Work across files** — Edit in one, reference the other
5. **Run tsk with persistence** — Tasks survive terminal close

Your project structure:
```
src/tsk/
├── __init__.py
├── main.py      # CLI commands
└── models.py    # Task, Status, TaskStore
```

## Common Issues

**"Import error: cannot import from tsk.models"**

Make sure your `models.py` is saved and in the right location: `src/tsk/models.py`

**"Window navigation doesn't work with Ctrl-h"**

Did you add the keymaps to your config? Did you restart Neovim after?

**"I can't see both files"**

You might have closed a split. Open it again: `:vs src/tsk/models.py`

**"Tasks aren't persisting"**

Check `~/.tsk/tasks.json` exists. If not, make sure TaskStore's `__init__` ran (no import errors).

**"Ctrl-h opens help instead of moving left"**

Some terminals intercept Ctrl-h. Try in a different terminal, or use `Ctrl-w h` as fallback.

## The Insight

You just experienced why Vim users don't need file tabs or a mouse.

- Splits let you see what matters
- Buffers let you have everything loaded
- Fast navigation means you never wait

The project is growing. Two files now. Soon it'll be five, ten, twenty. The skills scale. The workflow doesn't change.

Next lesson, we add fuzzy finding. Because `:e src/tsk/models.py` is too much typing when you can just hit `<leader>ff` and type "mod".

---

[Next: Lesson 05 - Plugins and Fuzzy Finding →](../05-plugins-and-fuzzy-finding/)
