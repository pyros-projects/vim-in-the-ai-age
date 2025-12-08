# Lesson 04 Exercises: Files and Buffers

Practice working with multiple files until splits feel natural.

## Setup

```bash
cd ~/projects/tsk
nvim src/tsk/main.py
```

---

## Exercise 1: Create Your First Split

**Task:** Open models.py in a vertical split alongside main.py.

**Commands:**
1. You're in main.py
2. `:vs src/tsk/models.py`
3. You now have two windows

**Verify:** You can see both files side by side.

---

## Exercise 2: Navigate Between Windows

**Task:** Move between main.py and models.py using keyboard only.

**Commands:**
1. `Ctrl-h` — move to left window (main.py)
2. `Ctrl-l` — move to right window (models.py)
3. Do it 5 times. Get fast.

**If Ctrl-h/l don't work:** Make sure you added the keymaps to your config. Fallback: `Ctrl-w h` and `Ctrl-w l`.

---

## Exercise 3: Open a Third File

**Task:** Open `__init__.py` in a horizontal split below models.py.

**Commands:**
1. Make sure you're in models.py (`Ctrl-l`)
2. `:sp src/tsk/__init__.py`
3. You now have three windows

**Layout:**
```
┌────────────┬────────────┐
│  main.py   │ models.py  │
│            ├────────────┤
│            │ __init__.py│
└────────────┴────────────┘
```

---

## Exercise 4: Close a Window

**Task:** Close the `__init__.py` window, keep the others.

**Commands:**
1. Navigate to `__init__.py` (`Ctrl-j` from models.py)
2. `Ctrl-w q` — close this window
3. Back to two windows

**Alternative:** `:q` also closes the current window.

---

## Exercise 5: Use the Buffer List

**Task:** See all loaded buffers and switch between them.

**Commands:**
1. `:ls` — see all buffers
2. Note the numbers and names
3. `:b main` — switch to main.py (partial match works)
4. `:b mod` — switch to models.py
5. `:bn` — next buffer
6. `:bp` — previous buffer

**Note:** Buffers stay loaded even if not visible. That's the point.

---

## Exercise 6: Close All Other Windows

**Task:** You have two splits. Make main.py fullscreen.

**Commands:**
1. Navigate to main.py (`Ctrl-h`)
2. `Ctrl-w o` — close all OTHER windows
3. main.py is now fullscreen

**Reopen the split:** `:vs src/tsk/models.py`

---

## Exercise 7: Resize Splits

**Task:** Make the left window (main.py) wider.

**Commands:**
1. Navigate to main.py
2. `20Ctrl-w >` — 20 columns wider
3. `Ctrl-w =` — reset to equal

**Vertical resize (for horizontal splits):**
- `Ctrl-w +` — taller
- `Ctrl-w -` — shorter

---

## Exercise 8: Edit Across Files

**Task:** Add a `clear` command to main.py that uses TaskStore.

**Commands:**
1. Open both files in splits: `:vs src/tsk/models.py`
2. In models.py, look at TaskStore methods (reference)
3. Switch to main.py (`Ctrl-h`)
4. Navigate to after the `rm` function
5. Add this function:

```python
@app.command()
def clear():
    """Remove all completed tasks."""
    store = TaskStore()
    # We need to add this method to TaskStore!
    count = store.clear_completed()
    print(f"Cleared {count} completed task(s)")
```

6. Switch to models.py (`Ctrl-l`)
7. Add the method to TaskStore:

```python
def clear_completed(self) -> int:
    original_count = len(self.tasks)
    self.tasks = [t for t in self.tasks if t.status != Status.DONE]
    self._save()
    return original_count - len(self.tasks)
```

8. Save both: `:wa`

**Test:**
```bash
uv run tsk add "Test task"
uv run tsk done 1
uv run tsk clear
uv run tsk list
```

---

## Exercise 9: Open File Under Cursor

**Task:** Jump to the file in an import statement.

**Commands:**
1. In main.py, find the line: `from tsk.models import TaskStore, Status`
2. Put cursor on `models`
3. `gf` — go to file

**What happens:** Vim tries to open the file. It might work depending on your path settings.

**Better way (coming in lesson 06):** With LSP, `gd` goes to definition across files.

---

## Exercise 10: Buffer-Only Workflow

**Task:** Work with buffers without visible splits.

**Commands:**
1. Close all splits: `Ctrl-w o` (from main.py)
2. Open models.py in same window: `:e src/tsk/models.py`
3. Check buffers: `:ls`
4. Switch back: `:b main`
5. Switch again: `:b mod`

**The point:** You don't need splits to have multiple files ready. Buffers are always there.

---

## Exercise 11: Write All and Quit All

**Task:** Save everything and exit cleanly.

**Commands:**
1. Make some small edit in both files
2. `:wa` — write all modified buffers
3. `:qa` — quit all

**Or combined:** `:wqa` — write all and quit all

**If you have unsaved changes:** `:qa!` quits without saving (careful!)

---

## Exercise 12: The Vertical Edit Workflow

**Task:** Practice the real workflow — reference and edit.

**Scenario:** You need to add a `priority` field to Task.

**Commands:**
1. Open splits: `nvim src/tsk/main.py`, then `:vs src/tsk/models.py`
2. In models.py, find the Task class
3. Add a field: `priority: str = "normal"`
4. Update `to_dict`: add `"priority": self.priority`
5. Update `from_dict`: add `priority=data.get("priority", "normal")`
6. Switch to main.py (`Ctrl-h`)
7. Update the `add` command to accept optional priority
8. Update `list` to show priority

This is the workflow: reference on one side, edit on the other.

---

## Challenge: Speed Run

**Task:** Starting from scratch, recreate the two-file structure in under 5 minutes.

1. Delete `~/.tsk/tasks.json` (fresh start)
2. Open Neovim with splits
3. Navigate efficiently
4. Run all tsk commands to verify

Can you do the full verification in under 2 minutes once files are ready?

---

## Checkpoint Verification

```bash
# Test all commands
uv run tsk add "Buffer exercise done"
uv run tsk add "Splits are easy now"
uv run tsk list
uv run tsk done 1
uv run tsk list
uv run tsk clear
uv run tsk list
uv run tsk rm 2
uv run tsk list
```

All commands should work. Tasks should persist across terminal restarts.

---

## Commands Learned

### Window Commands

| Command | Effect |
|---------|--------|
| `:vs file` | Vertical split |
| `:sp file` | Horizontal split |
| `Ctrl-h/j/k/l` | Navigate windows |
| `Ctrl-w q` | Close window |
| `Ctrl-w o` | Close other windows |
| `Ctrl-w =` | Equal size |
| `Ctrl-w >/<` | Wider/narrower |
| `Ctrl-w +/-` | Taller/shorter |

### Buffer Commands

| Command | Effect |
|---------|--------|
| `:e file` | Open file |
| `:ls` | List buffers |
| `:b name` | Switch buffer |
| `:bn` / `:bp` | Next/prev buffer |
| `:bd` | Delete buffer |
| `:wa` | Write all |
| `:qa` | Quit all |
| `gf` | Go to file under cursor |

---

Multi-file editing is now in your toolkit. Next up: fuzzy finding, because typing paths is for chumps.
