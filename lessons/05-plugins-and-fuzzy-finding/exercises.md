# Lesson 05 Exercises: Plugins and Fuzzy Finding

Practice until `<leader>ff` feels faster than your file tree.

## Setup

Make sure your config has all the plugins from the lesson. Then:

```bash
cd ~/projects/tsk
nvim .
```

---

## Exercise 1: Find Files by Name

**Task:** Open `models.py` using telescope.

**Commands:**
1. `<leader>ff` — open file finder
2. Type "mod"
3. Press `Enter`

**Verify:** You're now in models.py. No `:e`, no full path typed.

---

## Exercise 2: Find Files in a Split

**Task:** Open `main.py` in a vertical split from telescope.

**Commands:**
1. `<leader>ff`
2. Type "main"
3. Press `Ctrl-v` instead of Enter

**Verify:** You now have models.py and main.py side by side.

---

## Exercise 3: Search Code Content

**Task:** Find every file that contains "TaskStore".

**Commands:**
1. `<leader>fg` — live grep
2. Type "TaskStore"
3. See results from multiple files
4. Navigate with `Ctrl-j`/`Ctrl-k`
5. Press `Enter` to jump to one

**Verify:** You jumped directly to a line containing "TaskStore".

---

## Exercise 4: Search and Open in Split

**Task:** Search for "Status.DONE" and open it in a horizontal split.

**Commands:**
1. `<leader>fg`
2. Type "Status.DONE"
3. Press `Ctrl-x` (horizontal split)

**Verify:** The file opened in a horizontal split below your current window.

---

## Exercise 5: Switch Between Buffers

**Task:** Open 3 different files, then switch between them using telescope.

**Commands:**
1. Open main.py: `<leader>ff`, "main", `Enter`
2. Open models.py: `<leader>ff`, "mod", `Enter`
3. Open `__init__.py`: `<leader>ff`, "init", `Enter`
4. Now switch to main.py: `<leader>fb`, type "main", `Enter`

**Verify:** All three files are in your buffer list (`:ls`), and you switched without typing paths.

---

## Exercise 6: Use the File Tree

**Task:** Create a new test file using nvim-tree.

**Commands:**
1. `<leader>e` — toggle file tree
2. Navigate to `src/tsk/` folder (use `j`/`k` to move, `Enter` to expand)
3. Press `a` — add file
4. Type "utils.py", press `Enter`
5. `<leader>e` — close tree
6. Open the new file: `<leader>ff`, "util", `Enter`

**Verify:** `utils.py` exists and is open.

---

## Exercise 7: Delete a File

**Task:** Delete the utils.py file you just created.

**Commands:**
1. `<leader>e` — open tree
2. Navigate to `utils.py`
3. Press `d` — delete
4. Confirm with `y`
5. `<leader>e` — close tree

**Verify:** File is gone. `<leader>ff` "util" shows nothing.

---

## Exercise 8: Rename a File

**Task:** Create a file, then rename it.

**Commands:**
1. `<leader>e` — open tree
2. Navigate to `src/tsk/`
3. `a` — create file: "temp.py"
4. Navigate to the new file
5. `r` — rename
6. Type "helpers.py"
7. `<leader>e` — close tree
8. `<leader>ff` "help" — verify it opens

**Clean up:** Delete helpers.py using the tree (`d`).

---

## Exercise 9: Search Help

**Task:** Find documentation for the "tabstop" option.

**Commands:**
1. `<leader>fh` — help tags
2. Type "tabstop"
3. Press `Enter`

**Verify:** Neovim's help for tabstop opens. This is how you learn Vim without leaving Vim.

---

## Exercise 10: Quick Project Overview

**Task:** Get a sense of all Python files in your project.

**Commands:**
1. `<leader>ff`
2. Type ".py"
3. Look at all matches

**Alternative with grep:**
1. `<leader>fg`
2. Type "def " (with the space)
3. See every function definition in your project

---

## Exercise 11: The Real Workflow

**Task:** Simulate a real editing session.

Scenario: You need to add a `get` method to TaskStore that retrieves a task by ID.

**Commands:**
1. `<leader>fg` — search for "class TaskStore"
2. Jump to it
3. Find where methods are defined
4. Add this method:

```python
def get(self, task_id: int) -> Task | None:
    for task in self.tasks:
        if task.id == task_id:
            return task
    return None
```

5. `<leader>fg` — search for "def done"
6. Update the `done` command to use `store.get()`:

```python
@app.command()
def done(task_id: int):
    """Mark a task as complete."""
    store = TaskStore()
    task = store.get(task_id)
    if task:
        task.status = Status.DONE
        store._save()
        print(f"✓ Completed: {task.text}")
    else:
        print(f"Task #{task_id} not found")
```

7. `:wa` — save all

**Test:**
```bash
uv run tsk add "Test the get method"
uv run tsk done 1
uv run tsk list
```

---

## Exercise 12: Speed Challenge

**Task:** Starting from a terminal, complete these tasks in under 30 seconds:

1. Open project with `nvim .`
2. Find and open main.py (telescope)
3. Find the word "print" (live grep)
4. Switch to models.py (buffer switch)
5. Open file tree
6. Close file tree
7. Quit all (`:qa`)

**Time yourself.** Repeat until you beat 20 seconds.

---

## Challenge: No Path Typing

**Task:** For the rest of this session, **never type a file path**.

Rules:
- `:e path` is banned
- Use only `<leader>ff`, `<leader>fg`, `<leader>fb`, `<leader>e`
- See how long you can go

This forces the habits that make you fast.

---

## Checkpoint Verification

```bash
# Should work from lesson 04
uv run tsk add "Plugins working"
uv run tsk list
uv run tsk done 1
uv run tsk clear
```

Also verify:
1. `<leader>ff` opens telescope find_files
2. `<leader>fg` opens telescope live_grep
3. `<leader>fb` opens telescope buffers
4. `<leader>e` toggles nvim-tree
5. Your theme is visible (catppuccin-mocha)

---

## Commands Learned

### Telescope

| Command | Action |
|---------|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Switch buffers |
| `<leader>fh` | Help tags |
| `Ctrl-j/k` | Navigate results |
| `Enter` | Open file |
| `Ctrl-v` | Open in vertical split |
| `Ctrl-x` | Open in horizontal split |
| `Esc` | Close telescope |

### nvim-tree

| Command | Action |
|---------|--------|
| `<leader>e` | Toggle tree |
| `j/k` | Navigate |
| `Enter` | Open/expand |
| `a` | Create file |
| `d` | Delete file |
| `r` | Rename file |
| `q` | Close tree |

### Plugin Management

| Command | Action |
|---------|--------|
| `:Lazy` | Open plugin manager |
| `:Lazy update` | Update all plugins |
| `:Lazy clean` | Remove unused plugins |

---

Fuzzy finding is now muscle memory. Next: IDE features with LSP.
