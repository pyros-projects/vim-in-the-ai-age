# Keybinding Reference

Every keybinding taught in this tutorial, with context about when you learned it and why.

## How This Reference Works

Each binding includes:
- **Lesson**: Where you learned it
- **Context**: Why you needed it at that point

Use this as a lookup when you forget something. If you haven't done the lesson yet, the binding might not make sense.

---

## Modes

| Key | Action | Lesson | Context |
|-----|--------|--------|---------|
| `i` | Enter insert mode | 01 | Type new text |
| `a` | Insert after cursor | 01 | Append to existing text |
| `A` | Insert at end of line | 01 | Add to line without navigating |
| `o` | Open line below | 01 | New line without Enter |
| `O` | Open line above | 01 | Insert above current line |
| `Esc` | Return to normal | 01 | Stop typing, start commanding |
| `jk` | Return to normal (custom) | 01 | Faster than reaching for Esc |
| `v` | Visual mode | 03 | Select text for operations |
| `V` | Visual line mode | 03 | Select entire lines |
| `Ctrl-v` | Visual block mode | 03 | Column selection |

---

## Navigation

### Basic Movement

| Key | Action | Lesson | Context |
|-----|--------|--------|---------|
| `h/j/k/l` | Left/down/up/right | 01 | Home row movement |
| `w` | Next word start | 02 | Navigate by words |
| `W` | Next WORD start | 02 | Skip punctuation |
| `b` | Previous word start | 02 | Go back by words |
| `e` | Word end | 02 | Jump to end of word |

### Line Movement

| Key | Action | Lesson | Context |
|-----|--------|--------|---------|
| `0` | Line start | 02 | Beginning of line |
| `^` | First non-blank | 02 | Start of code (skip indent) |
| `$` | Line end | 02 | End of line |
| `f{char}` | Forward to char | 02 | Jump to specific character |
| `t{char}` | Until char | 02 | Stop before character |
| `;` | Repeat f/t | 02 | Keep jumping to same char |

### File Movement

| Key | Action | Lesson | Context |
|-----|--------|--------|---------|
| `gg` | File start | 02 | Top of file |
| `G` | File end | 02 | Bottom of file |
| `{n}G` | Go to line n | 02 | Jump to specific line |
| `Ctrl-d` | Half page down | 02 | Fast scrolling |
| `Ctrl-u` | Half page up | 02 | Fast scrolling |
| `{` | Previous paragraph | 02 | Navigate code blocks |
| `}` | Next paragraph | 02 | Navigate code blocks |

### Search

| Key | Action | Lesson | Context |
|-----|--------|--------|---------|
| `/pattern` | Search forward | 02 | Find text in file |
| `?pattern` | Search backward | 02 | Find text above |
| `n` | Next match | 02 | Cycle through results |
| `N` | Previous match | 02 | Go back in results |
| `*` | Search word under cursor | 02 | Quick search current word |
| `#` | Search word backward | 02 | Search current word up |

---

## Editing

### Operators

| Key | Action | Lesson | Context |
|-----|--------|--------|---------|
| `d{motion}` | Delete | 03 | Remove text |
| `c{motion}` | Change | 03 | Delete and enter insert |
| `y{motion}` | Yank | 03 | Copy text |
| `>` | Indent right | 03 | Increase indentation |
| `<` | Indent left | 03 | Decrease indentation |
| `=` | Auto-indent | 03 | Fix indentation |
| `gU{motion}` | Uppercase | 03 | Convert to upper |
| `gu{motion}` | Lowercase | 03 | Convert to lower |

### Line Operations

| Key | Action | Lesson | Context |
|-----|--------|--------|---------|
| `dd` | Delete line | 03 | Remove entire line |
| `yy` | Yank line | 03 | Copy entire line |
| `cc` | Change line | 03 | Replace entire line |
| `D` | Delete to end | 03 | Delete rest of line |
| `C` | Change to end | 03 | Replace rest of line |

### Quick Edits

| Key | Action | Lesson | Context |
|-----|--------|--------|---------|
| `x` | Delete char | 03 | Quick delete |
| `r{char}` | Replace char | 03 | Single character fix |
| `~` | Toggle case | 03 | Switch upper/lower |
| `.` | Repeat last change | 03 | Powerful repetition |
| `u` | Undo | 03 | Fix mistakes |
| `Ctrl-r` | Redo | 03 | Undo the undo |

### Paste

| Key | Action | Lesson | Context |
|-----|--------|--------|---------|
| `p` | Paste after | 03 | Put after cursor |
| `P` | Paste before | 03 | Put before cursor |
| `"+y` | Yank to clipboard | 03 | System clipboard |
| `"+p` | Paste from clipboard | 03 | From system clipboard |

---

## Files & Buffers

| Key | Action | Lesson | Context |
|-----|--------|--------|---------|
| `:e {file}` | Open file | 04 | Edit another file |
| `:w` | Save | 01 | Write file |
| `:w {file}` | Save as | 04 | Write to new name |
| `:q` | Quit | 01 | Close window |
| `:wq` | Save and quit | 01 | Common combo |
| `:q!` | Force quit | 01 | Discard changes |

### Windows

| Key | Action | Lesson | Context |
|-----|--------|--------|---------|
| `Ctrl-w v` | Vertical split | 04 | Side-by-side editing |
| `Ctrl-w s` | Horizontal split | 04 | Top-bottom editing |
| `Ctrl-w h/j/k/l` | Navigate windows | 04 | Move between splits |
| `Ctrl-w q` | Close window | 04 | Close current split |
| `Ctrl-w =` | Equal sizes | 04 | Balance splits |
| `Ctrl-w _` | Maximize height | 04 | Focus one split |
| `Ctrl-w |` | Maximize width | 04 | Focus one split |

### Buffers

| Key | Action | Lesson | Context |
|-----|--------|--------|---------|
| `:bn` | Next buffer | 04 | Cycle buffers |
| `:bp` | Previous buffer | 04 | Go back |
| `:bd` | Close buffer | 04 | Remove from list |
| `:ls` | List buffers | 04 | See what's open |

---

## Plugins (Lesson 05+)

### Telescope

| Key | Action | Lesson | Context |
|-----|--------|--------|---------|
| `Space f f` | Find files | 05 | Fuzzy file search |
| `Space f g` | Live grep | 05 | Search file contents |
| `Space f b` | List buffers | 05 | Switch buffers |
| `Enter` | Open file | 05 | Confirm selection |
| `Ctrl-v` | Open in vsplit | 05 | Open beside current |
| `Ctrl-x` | Open in split | 05 | Open below current |
| `Ctrl-t` | Open in tab | 05 | New tab |
| `Esc` | Close | 05 | Cancel search |

### File Tree

| Key | Action | Lesson | Context |
|-----|--------|--------|---------|
| `Space e` | Toggle tree | 05 | Show/hide explorer |
| `Enter` | Open file | 05 | Edit selected |
| `a` | Create file | 05 | New file |
| `d` | Delete file | 05 | Remove file |
| `r` | Rename | 05 | Change name |

---

## LSP (Lesson 06)

| Key | Action | Lesson | Context |
|-----|--------|--------|---------|
| `gd` | Go to definition | 06 | Jump to where defined |
| `gr` | Go to references | 06 | Find all usages |
| `K` | Hover docs | 06 | Show documentation |
| `Space rn` | Rename | 06 | Rename across files |
| `Space ca` | Code actions | 06 | Quick fixes |
| `Space d` | Show diagnostic | 06 | Error details |
| `[d` | Previous diagnostic | 06 | Navigate errors |
| `]d` | Next diagnostic | 06 | Navigate errors |

### Completion

| Key | Action | Lesson | Context |
|-----|--------|--------|---------|
| `Ctrl-Space` | Trigger completion | 06 | Manually invoke |
| `Tab` | Next item | 06 | Cycle options |
| `Shift-Tab` | Previous item | 06 | Go back |
| `Enter` | Accept | 06 | Confirm selection |

---

## Terminal (Lesson 07)

| Key | Action | Lesson | Context |
|-----|--------|--------|---------|
| `Ctrl-\` | Toggle terminal | 07 | Quick access |
| `Space t f` | Float terminal | 07 | Overlay terminal |
| `Space t v` | Vertical terminal | 07 | Side split |
| `Ctrl-\ Ctrl-n` | Exit terminal mode | 07 | Back to normal mode |

---

## Claude Code (Lesson 08+)

| Key | Action | Lesson | Context |
|-----|--------|--------|---------|
| `Space c c` | Open Claude | 08 | Side-by-side AI |
| `Space y p` | Yank file path | 08 | Share path with Claude |
| `Space y l` | Yank file:line | 08 | Point to exact location |

---

## Git Integration (Lesson 09)

| Key | Action | Lesson | Context |
|-----|--------|--------|---------|
| `]c` | Next hunk | 09 | Review Claude's changes |
| `[c` | Previous hunk | 09 | Go back |
| `Space h p` | Preview hunk | 09 | See what changed |
| `Space h r` | Reset hunk | 09 | Undo specific change |
| `Space h b` | Blame line | 09 | Who wrote this |

---

## Pattern Recognition

Once you know these patterns, you can combine freely:

```
d + iw = delete inner word
c + iw = change inner word
y + iw = yank inner word

d + i" = delete inside quotes
c + i" = change inside quotes
y + i" = yank inside quotes

d + 2w = delete 2 words
c + 2w = change 2 words
y + 2w = yank 2 words
```

The grammar is: **operator + count + motion/object**

---

*This reference covers bindings taught in the tutorial. Vim has many more. Learn these first.*
