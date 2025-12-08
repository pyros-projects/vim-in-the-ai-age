# Lesson 03 Exercises: Editing Grammar

Practice the verb + noun grammar until it becomes muscle memory.

## Setup

Open your tsk project:

```bash
cd ~/projects/tsk
nvim src/tsk/main.py
```

---

## Exercise 1: Change Inside Quotes

Find the docstring `"""Add a new task."""`

**Task:** Change it to `"""Create a new task and add it to the list."""`

**Commands:**
1. Navigate to the line (try `/Add a new` or just `}` to jump by sections)
2. `ci"` - change inside quotes
3. Type the new text
4. `jk` to exit

**Verify:** The docstring changed, the triple quotes remained.

---

## Exercise 2: Delete and Retype

Find the `done` function. It still has a TODO.

**Task:** Replace the entire print line with working code.

**Commands:**
1. Navigate to the print line inside `done`
2. `cc` - change entire line
3. Type: `print(f"TODO: Marking #{task_id} done (lesson 04)")`
4. `jk`

**Alternative:** `S` does the same as `cc` - deletes line content, enters insert.

---

## Exercise 3: Yank and Paste a Function

We need a `rm` function that's similar to `done`.

**Task:** Copy the entire `done` function, paste it below, modify it.

**Commands:**
1. Navigate to `@app.command()` above `def done`
2. `V` - visual line mode
3. `}` - select to next blank line (or `4j` to select 4 lines)
4. `y` - yank
5. `}` - move past the function
6. `p` - paste below
7. Modify: change `done` to `rm`, change docstring, update print

**Target:**
```python
@app.command()
def rm(task_id: int):
    """Delete a task."""
    print(f"TODO: Deleting #{task_id} (lesson 04)")
```

---

## Exercise 4: Change Word

In the `list_tasks` function, find:
```python
status = "✓" if t.status == Status.DONE else "○"
```

**Task:** Change `status` (the variable) to `icon`.

**Commands:**
1. Navigate to the variable `status` (not `Status` or `t.status`)
2. `ciw` - change inner word
3. Type: `icon`
4. `jk`
5. Find the next `status` on the print line
6. `.` - repeat the change

**Or use search:** `/status<Enter>`, then `ciw`, type `icon`, `jk`, then `n`, `.`, `n`, `.`

---

## Exercise 5: Delete Inside Parentheses

Find the `app.command("list")` decorator.

**Task:** Remove `"list"` so it becomes just `@app.command()`

**Commands:**
1. Navigate to that line
2. `di(` - delete inside parentheses
3. Done. The parentheses remain, content is gone.

**Restore it:** `u` to undo. We want to keep `"list"`.

---

## Exercise 6: Indent a Block

Let's practice indentation. Create a test block:

1. Go to end of file: `G`
2. `O` - open line above
3. Type:
```python
if __name__ == "__main__":
print("test")
print("more")
app()
```

Notice the prints aren't indented. Fix it:

1. Navigate to first `print`
2. `V` - visual line
3. `2j` - select 2 more lines
4. `>` - indent right

**Better way:**
1. Position on the `if` line
2. `>i{` ... wait, there's no braces in Python.
3. Instead: `>3j` - indent 3 lines down

Now delete this test block - it was just practice:
1. Navigate to the `if __name__` line you added
2. `V4jd` - visual select 4 lines, delete

---

## Exercise 7: The Dot Command

Add three new tasks to the docstrings throughout the file:

**Task:** Every function docstring should end with " [tsk]"

Example: `"""Add a new task."""` → `"""Add a new task. [tsk]"""`

**Commands:**
1. Find first docstring: `/"""/`
2. Navigate inside quotes
3. `$` - end of line (you're now on the last `"`)
4. `i` - insert before cursor
5. Type: ` [tsk]`
6. `jk`
7. `n` - next docstring
8. `.` - repeat!
9. `n`, `.`, `n`, `.`...

**The power:** You defined an edit once. `.` repeats it everywhere.

---

## Exercise 8: Delete to Pattern

**Task:** In main.py, delete from the `rm` function to the end of file, then undo.

**Commands:**
1. Navigate to `@app.command()` above `def rm`
2. `dG` - delete to end of file
3. Everything from here down is gone
4. `u` - undo immediately!

This is powerful but dangerous. Good thing `u` exists.

---

## Exercise 9: Change Inside Braces (Bonus)

This one's for languages with braces, but let's practice the concept.

Create a test dict at the end of your file:

```python
test = {"name": "value", "count": 42}
```

**Task:** Change the dictionary contents.

**Commands:**
1. Cursor anywhere inside the `{}`
2. `ci{` - change inside braces
3. Type: `"updated": True`
4. `jk`

**Result:** `test = {"updated": True}`

Now delete the whole line: `dd`

---

## Exercise 10: Visual Block Mode (Advanced)

Visual block selects a rectangle. Useful for editing columns.

Create this at the end of your file:
```python
# TODO: task 1
# TODO: task 2
# TODO: task 3
```

**Task:** Remove "TODO: " from all three lines at once.

**Commands:**
1. Navigate to the `T` in first `TODO`
2. `Ctrl-v` - visual block mode
3. `2j` - extend down 2 lines
4. `e` - extend to end of word (selects `TODO` on all lines)
5. `l` - extend one more (selects the `:`)
6. `l` - extend one more (selects the space)
7. `d` - delete the block

**Result:**
```python
# task 1
# task 2
# task 3
```

Now `dd` three times (or `3dd`) to clean up.

---

## Challenge: Build It Without Instructions

Delete your entire `add` function body and rewrite it from memory:

1. Navigate to `def add`
2. `}` - jump to the blank line after the function
3. `d{` - delete backwards to previous blank (deletes function body)
4. Rewrite the function using `o`, `cc`, and what you've learned

Can you write it in under 60 seconds?

---

## Checkpoint Verification

Run these commands and verify output:

```bash
uv run tsk add "Exercise complete"
uv run tsk list
```

Expected:
```
✓ Added task #1: Exercise complete

  ○ [1] Exercise complete
```

If it works, you've successfully:
- Used `ci"` to change quoted strings
- Used `ciw` to change words
- Used `dd`, `cc` for line operations
- Used `.` to repeat edits
- Used visual mode for multi-line operations
- Built working code with the Vim grammar

---

## Commands Learned

| Command | Action |
|---------|--------|
| `dw` | Delete word |
| `d$` | Delete to end of line |
| `dd` | Delete entire line |
| `cw` | Change word |
| `cc` | Change entire line |
| `ciw` | Change inner word |
| `ci"` | Change inside quotes |
| `di(` | Delete inside parentheses |
| `yy` | Yank (copy) line |
| `p` | Paste after |
| `P` | Paste before |
| `.` | Repeat last change |
| `V` | Visual line mode |
| `Ctrl-v` | Visual block mode |
| `>` | Indent (in visual or with motion) |
| `u` | Undo |
| `Ctrl-r` | Redo |

---

You now have the grammar. The rest is just practice until it's automatic.
