# Lesson 06 Exercises: LSP and Completion

Practice until `gd` and `K` are muscle memory.

## Setup

Make sure your config has all the LSP plugins from the lesson. Then:

```bash
cd ~/projects/tsk
nvim src/tsk/main.py
```

Wait for pyright to initialize. Check with `:LspInfo` — you should see pyright attached.

---

## Exercise 1: Trigger Completion

**Task:** Use autocompletion to call a TaskStore method.

**Commands:**
1. Find the `add` function
2. After `store = TaskStore()`, add a new line
3. Type `store.`
4. Completion menu appears
5. Use `Tab` to navigate to `add`
6. Press `Enter` to select
7. Complete the line: `store.add(task)`

**Verify:** You wrote code using completion, not memory.

---

## Exercise 2: Go to Definition

**Task:** Jump from usage to definition.

**Commands:**
1. In main.py, find where `TaskStore` is used
2. Put cursor on `TaskStore`
3. Press `gd`
4. You're now in models.py at the class definition
5. Press `Ctrl-o` to jump back

**Verify:** You navigated between files without typing paths or using telescope.

---

## Exercise 3: Chain Definitions

**Task:** Follow a chain of definitions.

**Commands:**
1. In main.py, find `Status.DONE`
2. `gd` on `Status`
3. You're at the Status enum
4. Find `DONE` in the enum, `gd` on it
5. Press `Ctrl-o` twice to get back to main.py

**This is how you explore unfamiliar code.** Jump in, understand, jump back.

---

## Exercise 4: Hover Documentation

**Task:** Read documentation without leaving your position.

**Commands:**
1. In main.py, put cursor on `store.add`
2. Press `K`
3. Read the docstring in the hover window
4. Move cursor or press `K` again to close
5. Try `K` on `TaskStore`, `Status`, `typer.Typer`

**Verify:** You can read docs for anything without jumping away.

---

## Exercise 5: Find References

**Task:** Find all usages of a function.

**Commands:**
1. In models.py, find the `_save` method
2. Put cursor on `_save`
3. Press `gr`
4. Telescope shows all references
5. Navigate the list with `Ctrl-j/k`
6. Press `Enter` to jump to one
7. `Ctrl-o` to go back

**Use case:** "What calls this function? Is it safe to change?"

---

## Exercise 6: Rename Symbol

**Task:** Rename a variable across the codebase.

**Commands:**
1. In models.py, find the `task_id` parameter in any method
2. Put cursor on `task_id`
3. Press `<leader>rn`
4. Type: `id`
5. Press `Enter`
6. Check all usages changed

**Undo:** Press `u` to revert (might need multiple undos for multiple files)

**Better test:** Rename something more unique, like `_load` to `_read_from_disk`. Then undo.

---

## Exercise 7: Navigate Diagnostics

**Task:** Create and navigate errors.

**Commands:**
1. In main.py, add this bad line somewhere:
   ```python
   broken = undefined_var + another_undefined
   ```
2. Save (`:w`)
3. See the error indicators appear
4. Press `]d` to jump to first diagnostic
5. Press `<leader>d` to see full message
6. Press `[d` to go to previous (if multiple)
7. Delete the bad line, save

**Verify:** You can find and read all errors without scrolling.

---

## Exercise 8: Code Actions

**Task:** Use code actions to fix an issue.

**Commands:**
1. In main.py, add an unused import:
   ```python
   import os
   ```
2. Save — pyright shows "os is not accessed"
3. Put cursor on the diagnostic
4. Press `<leader>ca`
5. If "remove unused import" is available, select it
6. Otherwise, manually delete and note that code actions vary by language

**Note:** Python code actions are limited compared to TypeScript. Not all diagnostics have fixes.

---

## Exercise 9: Completion Sources

**Task:** See different completion sources.

**Commands:**
1. Create a new function in main.py:
   ```python
   def test_completion():
       # Type each of these and observe:
       pass
   ```
2. Type `Task` — see LSP suggest the class
3. Type `stor` — see LSP suggest `store` (if in scope)
4. Type `"./` — see path completion
5. Delete the test function when done

**Observe:** The completion menu shows icons/labels for source type (LSP, buffer, path).

---

## Exercise 10: Signature Help

**Task:** See function parameters while typing.

**Commands:**
1. In main.py, start typing a function call:
   ```python
   store.add(
   ```
2. After the `(`, you might see signature help showing parameters
3. If not, press `Ctrl-Space` while inside the parentheses
4. Complete the call or delete

**Note:** Signature help behavior varies. Some setups show it automatically, some need triggers.

---

## Exercise 11: Explore with LSP

**Task:** Understand a class you've never seen.

**Commands:**
1. Open models.py
2. Go to `TaskStore` class
3. Use `K` on `Path` — see it's from pathlib
4. `gd` on `Path` — jump to the type stub
5. `Ctrl-o` back
6. Use `gr` on `_save` — see all callers
7. Use `K` on `json.dumps` — see the signature

**This is LSP-powered exploration.** You can understand any codebase this way.

---

## Exercise 12: The Full Workflow

**Task:** Add a feature using LSP throughout.

Scenario: Add a `count` command that shows how many tasks exist.

**Commands:**
1. `<leader>ff` → open main.py
2. Go to after the last command function
3. Start typing:
   ```python
   @app.command()
   def count():
       """Show task count."""
       store = TaskStore()
   ```
4. Type `store.` — use completion to see methods
5. None exist for count! We need to add one.
6. `gd` on `TaskStore` — jump to models.py
7. Add method:
   ```python
   def count(self) -> int:
       return len(self.tasks)
   ```
8. `Ctrl-o` — back to main.py
9. Continue typing, use completion for `store.count()`
10. Complete:
    ```python
        total = store.count()
        done = len([t for t in store.list_all() if t.status == Status.DONE])
        print(f"Total: {total} | Done: {done} | Pending: {total - done}")
    ```
11. Save all: `:wa`

**Test:**
```bash
uv run tsk add "Test task"
uv run tsk count
```

**Verify:** You used completion, navigation, and multiple files seamlessly.

---

## Exercise 13: Add Type Hints

**Task:** Improve your code with type hints, using LSP feedback.

**Commands:**
1. In main.py, find functions without return type hints
2. Add them:
   ```python
   def add(task: str) -> None:
   def list_tasks() -> None:
   def done(task_id: int) -> None:
   ```
3. Save — pyright now validates returns match
4. If any function returns something but says `-> None`, you'll get a diagnostic

**Verify:** LSP catches type mismatches.

---

## Challenge: Speed Navigation

**Task:** Navigate this sequence in under 30 seconds:

1. Open main.py (`<leader>ff`)
2. `gd` on `TaskStore` → jump to models.py
3. `gd` on `Task` → jump to Task class
4. `gr` on `id` → see references
5. `Esc` to close telescope
6. `K` on `Status` → read docs
7. `Ctrl-o` `Ctrl-o` `Ctrl-o` → back to main.py

**Time yourself.** Repeat until it's under 15 seconds.

---

## Checkpoint Verification

In your tsk project:

1. `:LspInfo` shows pyright attached
2. `gd` works on any symbol
3. `K` shows hover docs
4. `gr` finds references
5. `<leader>rn` renames symbols
6. Completion appears when typing `store.`
7. Diagnostics show for errors

```bash
# Test your code still works
uv run tsk add "LSP working"
uv run tsk list
uv run tsk count  # if you added it
```

---

## Commands Learned

### LSP Navigation

| Command | Action |
|---------|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Find references |
| `gi` | Go to implementation |
| `K` | Hover documentation |
| `Ctrl-o` | Jump back |
| `Ctrl-i` | Jump forward |

### LSP Actions

| Command | Action |
|---------|--------|
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |

### Diagnostics

| Command | Action |
|---------|--------|
| `]d` | Next diagnostic |
| `[d` | Previous diagnostic |
| `<leader>d` | Show diagnostic float |

### Completion

| Command | Action |
|---------|--------|
| `Tab` | Next item |
| `Shift-Tab` | Previous item |
| `Enter` | Accept |
| `Ctrl-Space` | Trigger manually |
| `Ctrl-e` | Cancel |

---

You now have IDE-level code intelligence. Next: running code and tests without leaving Neovim.
