# Lesson 02: Navigation Exercises

Practice on the code you just wrote. These exercises drill navigation on your tsk project.

## Setup

Make sure you're in your tsk project:

```bash
cd ~/projects/tsk
nvim src/tsk/main.py
```

You should see the skeleton code from the lesson. **Don't edit anything yet** - just navigate.

---

## Exercise 1: Word Motions

**Goal:** Move by words without thinking.

### Tasks

1. Go to line 1 (`gg`). Press `w` until you reach `Typer`. How many presses?

2. Go to line 6 (`6G`). Use `w` to move through `def add(task: str):`. Notice where it stops.

3. Same line - try `W` instead. Notice it takes fewer stops.

4. Go to line 10. Use `b` to move backwards through `print(f"TODO: Add task: {task}")`.

5. Practice `e` - it lands on the last character of each word instead of the first.

### Self-Check

- [ ] I can move forward by words with `w`
- [ ] I can move backward with `b`
- [ ] I understand when `W` is faster than `w`

---

## Exercise 2: Line Motions

**Goal:** Jump to line boundaries instantly.

### Tasks

1. Go to line 10 (`10G`). Press `0`. You're at the indentation.

2. Press `^`. Now you're at `p` in `print`.

3. Press `$`. You're at the end (the closing paren).

4. Practice: `^` → `$` → `^` → `$`. This is how you scan a line.

5. Try this on line 18 (the `done` function's print statement).

### Self-Check

- [ ] I know `^` goes to first character (not column 0)
- [ ] I know `$` goes to end of line
- [ ] I can quickly jump between start and end

---

## Exercise 3: File Motions

**Goal:** Teleport anywhere in the file.

### Tasks

1. Press `gg` to go to line 1. Press `G` to go to the last line. Do this 3 times fast.

2. Jump to specific lines:
   - `6G` → Should land on `@app.command()` above `add`
   - `11G` → Should land on the blank line after `add`
   - `20G` → Should land on `if __name__`

3. From line 1, use `}` to jump through each blank line. Count the sections.

4. From the bottom (`G`), use `{` to jump back up.

5. Try `Ctrl-d` and `Ctrl-u` - even in this small file, feel the half-page scroll.

### Self-Check

- [ ] `gg` and `G` are instant reflexes
- [ ] I can jump to any line with `{number}G`
- [ ] I can navigate by sections with `{` and `}`

---

## Exercise 4: Search

**Goal:** Find anything instantly.

### Tasks

1. From anywhere, type `/TODO<Enter>`. Jump to the first TODO.

2. Press `n` to go to the next TODO. Press `n` again. How many TODOs are there?

3. Press `N` to go backwards through the matches.

4. Put your cursor on `task` (any occurrence). Press `*`. Cycle through all `task` occurrences with `n`.

5. Search for a function: `/def add<Enter>`. You should land on the function definition.

6. Try searching backwards: `?app<Enter>`. Notice the direction.

7. Clear the search highlight with `:noh` or just press `Esc`.

### Self-Check

- [ ] I can search forward with `/pattern`
- [ ] I can cycle through matches with `n` and `N`
- [ ] I can use `*` to search for the word under cursor
- [ ] I can clear highlights with `:noh`

---

## Exercise 5: Counts

**Goal:** Multiply any motion.

### Tasks

1. Go to line 1 (`gg`). Type `5j`. You should be on line 6.

2. Type `3w` to jump forward 3 words.

3. Look at the `done` function. If it's 8 lines below you, type `8j`.

4. Type `2}` to jump forward 2 sections.

5. From anywhere, type `gg` then `4}` - this should get you near the end.

### Self-Check

- [ ] I can combine counts with any motion
- [ ] I use relative line numbers to know how far to jump
- [ ] `{count}{motion}` feels natural

---

## Exercise 6: Navigation Challenge

**Goal:** Combine everything. Find the fastest path.

### The Challenge

Starting from line 1, navigate to each target. **Use the fewest keystrokes possible.**

| Target | Your Solution |
|--------|---------------|
| The word `Typer` on line 3 | |
| First `TODO` | |
| The `done` function definition | |
| End of line 10 | |
| The string `"list"` | |
| Back to line 1 | |

### Optimal Solutions

<details>
<summary>Click to reveal</summary>

1. `3G` then `w` or `/Typer<Enter>`
2. `/TODO<Enter>`
3. `/def done<Enter>` or `14G`
4. `10G$`
5. `/"list<Enter>` or `/list<Enter>` then `n` if needed
6. `gg`

</details>

---

## Exercise 7: Real Navigation Scenarios

**Goal:** Practice like you're actually coding.

### Scenario 1: Find all functions

Use `/def <Enter>` then `n` repeatedly to jump through all function definitions.

### Scenario 2: Check all TODO items

Use `/TODO<Enter>` then `n` to find each TODO. In lesson 03, we'll replace these with real code.

### Scenario 3: Find where `task` is used

Put cursor on any `task`, press `*`, then `n` through all occurrences. This is how you track a variable through code.

### Scenario 4: Jump between functions

Use `}` and `{` to jump between the blank lines separating functions. This is structural navigation.

---

## Graduation Check

Before moving to lesson 03, verify you can:

| Skill | Test |
|-------|------|
| Word motions | Navigate a line using only `w`, `b`, `e` |
| Line boundaries | Jump to start (`^`) and end (`$`) instantly |
| File jumps | Go to any line with `{number}G` |
| Section jumps | Navigate between functions with `{` and `}` |
| Search | Find any word with `/` or `*` |
| Counts | Use `5j`, `3w`, etc. naturally |

Run your code to make sure it still works:

```bash
uv run tsk --help
uv run tsk add "Navigation complete!"
```

---

## What's Next

In lesson 03, we replace those TODO placeholders with real code. You'll learn the Vim grammar: operators + motions = power.

`d3w` = delete 3 words
`ci"` = change inside quotes
`yy` = copy a line

The motions you just learned become building blocks for editing.

---

[Back to Lesson 02 →](./README.md)
