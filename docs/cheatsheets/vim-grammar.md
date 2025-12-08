# Vim Grammar Cheatsheet

Vim commands are composable: **operator + [count] + motion/text-object**

Once you learn the grammar, you know hundreds of commands.

## Operators (Verbs)

What you want to do.

| Key | Action |
|-----|--------|
| `d` | Delete |
| `c` | Change (delete + enter insert mode) |
| `y` | Yank (copy) |
| `v` | Visual select |
| `>` | Indent right |
| `<` | Indent left |
| `=` | Auto-indent |
| `gU` | Uppercase |
| `gu` | Lowercase |

## Motions (Nouns)

Where to apply the operator.

### Character/Word

| Key | Motion |
|-----|--------|
| `h/j/k/l` | Left/down/up/right |
| `w` | Start of next word |
| `W` | Start of next WORD (whitespace-delimited) |
| `e` | End of word |
| `b` | Back to start of word |
| `0` | Start of line |
| `^` | First non-blank character |
| `$` | End of line |

### Line

| Key | Motion |
|-----|--------|
| `j/k` | Down/up one line |
| `gg` | First line of file |
| `G` | Last line of file |
| `{number}G` | Go to line number |
| `{` / `}` | Previous/next paragraph |

### Search

| Key | Motion |
|-----|--------|
| `f{char}` | Forward to character |
| `F{char}` | Backward to character |
| `t{char}` | Forward until character |
| `T{char}` | Backward until character |
| `/pattern` | Search forward |
| `?pattern` | Search backward |
| `n/N` | Next/previous search match |
| `*` | Search word under cursor |

## Text Objects

Used with operators. Format: `a` (around) or `i` (inside) + object.

| Key | Object |
|-----|--------|
| `w` | Word |
| `W` | WORD |
| `s` | Sentence |
| `p` | Paragraph |
| `"` | Double quotes |
| `'` | Single quotes |
| `` ` `` | Backticks |
| `(` or `)` | Parentheses |
| `[` or `]` | Brackets |
| `{` or `}` | Braces |
| `<` or `>` | Angle brackets |
| `t` | Tag (HTML/XML) |

## Combining It All

| Command | What It Does |
|---------|--------------|
| `dw` | Delete word |
| `d2w` | Delete 2 words |
| `diw` | Delete inner word (word under cursor) |
| `daw` | Delete around word (including space) |
| `ci"` | Change inside quotes |
| `ca"` | Change around quotes (including quotes) |
| `yi(` | Yank inside parentheses |
| `dit` | Delete inside tag |
| `d$` | Delete to end of line |
| `d0` | Delete to start of line |
| `dgg` | Delete to start of file |
| `dG` | Delete to end of file |
| `ct,` | Change until comma |
| `vaw` | Visual select around word |
| `>ip` | Indent inner paragraph |
| `gUiw` | Uppercase inner word |

## The Pattern

Once you know:
- `d` = delete
- `iw` = inner word

You automatically know:
- `diw` = delete inner word
- `ciw` = change inner word
- `yiw` = yank inner word
- `viw` = visual select inner word

Same with any operator + any motion/text-object.

## Counts

Add a number before motion:

| Command | What It Does |
|---------|--------------|
| `3w` | Move 3 words forward |
| `d3w` | Delete 3 words |
| `5j` | Move 5 lines down |
| `2dd` | Delete 2 lines |

## Special Cases

| Command | What It Does |
|---------|--------------|
| `dd` | Delete entire line (operator doubled) |
| `yy` | Yank entire line |
| `cc` | Change entire line |
| `D` | Delete to end of line (same as `d$`) |
| `C` | Change to end of line (same as `c$`) |
| `x` | Delete character under cursor |
| `r{char}` | Replace character under cursor |
| `~` | Toggle case |

## Think in Grammar

Don't memorize commands. Learn:
1. A few operators
2. A few motions
3. A few text objects

Then combine freely. That's the whole system.
