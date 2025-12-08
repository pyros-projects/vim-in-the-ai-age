# Keybindings Quick Reference

All keybindings taught in this tutorial, organized by lesson.

## Lesson 01: Survival

| Key | Action |
|-----|--------|
| `i` | Enter insert mode |
| `Esc` | Return to normal mode |
| `jk` | Return to normal mode (custom) |
| `:w` | Save file |
| `:q` | Quit |
| `:wq` | Save and quit |
| `:q!` | Quit without saving |

## Lesson 02: Navigation

| Key | Action |
|-----|--------|
| `h/j/k/l` | Left/down/up/right |
| `w` | Next word |
| `b` | Previous word |
| `e` | End of word |
| `0` | Start of line |
| `$` | End of line |
| `gg` | Top of file |
| `G` | Bottom of file |
| `{n}G` | Go to line n |
| `/pattern` | Search forward |
| `n/N` | Next/previous match |
| `*` | Search word under cursor |
| `Ctrl-d` | Half page down |
| `Ctrl-u` | Half page up |

## Lesson 03: Editing Grammar

| Key | Action |
|-----|--------|
| `d{motion}` | Delete |
| `c{motion}` | Change (delete + insert) |
| `y{motion}` | Yank (copy) |
| `p` | Paste after |
| `P` | Paste before |
| `u` | Undo |
| `Ctrl-r` | Redo |
| `.` | Repeat last change |
| `dd` | Delete line |
| `yy` | Yank line |
| `ciw` | Change inner word |
| `ci"` | Change inside quotes |

## Lesson 04: Files & Buffers

| Key | Action |
|-----|--------|
| `:e {file}` | Open file |
| `:w {file}` | Save as |
| `Ctrl-w v` | Vertical split |
| `Ctrl-w s` | Horizontal split |
| `Ctrl-w h/j/k/l` | Navigate windows |
| `Ctrl-w q` | Close window |
| `Ctrl-w =` | Equal window sizes |
| `:bn` | Next buffer |
| `:bp` | Previous buffer |
| `:bd` | Close buffer |

## Lesson 05: Plugins & Fuzzy Finding

| Key | Action |
|-----|--------|
| `Space f f` | Find files (telescope) |
| `Space f g` | Live grep (telescope) |
| `Space f b` | List buffers (telescope) |
| `Space e` | Toggle file tree |
| `Enter` | Open file (in telescope/tree) |
| `Ctrl-v` | Open in vsplit (telescope) |
| `Ctrl-x` | Open in split (telescope) |

## Lesson 06: LSP

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `K` | Hover documentation |
| `Space rn` | Rename symbol |
| `Space ca` | Code actions |
| `Space d` | Show diagnostics |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |
| `Ctrl-Space` | Trigger completion |
| `Tab` | Next completion item |
| `Enter` | Accept completion |

## Lesson 07: Terminal

| Key | Action |
|-----|--------|
| `Ctrl-\` | Toggle terminal |
| `Space t f` | Floating terminal |
| `Space t v` | Vertical terminal |
| `Ctrl-\ Ctrl-n` | Exit terminal mode |

### fzf Shell Bindings

| Key | Action |
|-----|--------|
| `Ctrl-r` | Fuzzy search history |
| `Ctrl-t` | Fuzzy find files |
| `Alt-c` | Fuzzy cd to directory |
| `**Tab` | Fuzzy path completion |

## Lesson 08: Claude Code

| Key | Action |
|-----|--------|
| `Space c c` | Open Claude Code split |
| `Space y p` | Yank current file path |
| `Space y l` | Yank file:line |

## Lesson 09: Git Integration

| Key | Action |
|-----|--------|
| `]c` | Next git hunk |
| `[c` | Previous git hunk |
| `Space h p` | Preview hunk |
| `Space h r` | Reset hunk |
| `Space h b` | Git blame line |

## Quick Reference Card

### Movement
```
    gg
    ^
    |
h <-+-> l
    |
    v
    G
```

### Operators
```
d = delete    y = yank
c = change    v = visual
> = indent    < = unindent
```

### Text Objects
```
w = word      s = sentence
" = quotes    ( = parens
{ = braces    t = tag
```

### Formula
```
[operator] + [count] + [motion/object]
```
