# Lesson 01: Exercises

Practice makes permanent. Do these until hjkl and jk feel natural.

## Exercise 1: Navigation Drill

1. Create a practice file:
   ```bash
   nvim practice.txt
   ```

2. Enter Insert mode (`i`) and type 10 lines of anything. Lorem ipsum, grocery list, whatever. Then escape with `jk`.

3. Navigate to:
   - The first line (press `k` until you're there, or `gg` for instant travel)
   - The last line (press `j` repeatedly, or `G` for instant)
   - The middle character of the middle line (hjkl only)

4. Delete the file when done: `rm practice.txt`

**Goal:** Get comfortable with hjkl. It'll feel slow. That's expected.

## Exercise 2: Insert Mode Variants

1. Open your config:
   ```bash
   nvim ~/.config/nvim/init.lua
   ```

2. Go to any line and try each insert mode:
   - `i` - insert before cursor
   - `a` - insert after cursor
   - `I` - insert at line beginning
   - `A` - insert at line end
   - `o` - new line below
   - `O` - new line above

3. After each, type "TEST", then `jk` to escape, then `u` to undo.

4. Quit without saving: `:q!`

**Goal:** Know which insert variant to use without thinking.

## Exercise 3: The jk Reflex

1. Open any file
2. Enter Insert mode (`i`)
3. Type a sentence
4. Exit with `jk`
5. Repeat 10 times

Now try:
1. Enter Insert mode
2. Type a sentence
3. Try to exit with Escape (notice how far your hand moves)
4. Repeat 5 times, alternating jk and Escape

**Goal:** Feel the difference. Choose jk.

## Exercise 4: Config Modification

Add this line to your config:

```lua
vim.opt.cursorline = true
```

This highlights the current line. Steps:

1. Open config: `nvim ~/.config/nvim/init.lua`
2. Navigate to the end of the file (`G`)
3. Add new line below (`o`)
4. Type the line above
5. Escape (`jk`)
6. Save (`:w`)
7. Quit and reopen to see the effect

**Goal:** Practice the full edit cycle: navigate → insert → type → escape → save.

## Exercise 5: Relative Number Practice

1. Open your config
2. Look at a line 7 lines below your cursor
3. The relative number should show "7"
4. Press `7j` - you should land exactly on that line
5. Look at a line 4 lines above
6. Press `4k` - you should land there

**Goal:** See how relative numbers eliminate counting.

## Bonus: Speed Challenge

Once comfortable with the basics:

1. Open a file with at least 50 lines
2. Start at line 1
3. Navigate to line 25 using only `j` (count how many keypresses)
4. Navigate back to line 1 using only `k`
5. Now try: from line 1, type `25j` (one command)

The single command is faster. That's the Vim way - there's always a more efficient method.

## Self-Assessment

You're ready for Lesson 02 when:

- [ ] jk feels more natural than reaching for Escape
- [ ] hjkl doesn't require conscious thought
- [ ] You can add a line to your config and reload Neovim
- [ ] You know the difference between `i`, `a`, `A`, `o`
- [ ] You've used `u` to undo at least 5 times

Don't rush. These fundamentals will accelerate everything that follows.

