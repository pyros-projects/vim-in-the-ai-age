# AI Workflows Cheatsheet

Patterns for working with Claude Code from Neovim.

## The Review Loop

The core workflow when Claude makes changes:

```
1. Ask Claude to make a change
         ↓
2. Claude edits file(s)
         ↓
3. Neovim auto-reloads (or :e to force)
         ↓
4. Review changes:
   - ]c / [c to jump through hunks
   - Space h p to preview each hunk
   - gd / K / gr to understand the code
         ↓
5. Test: :!pytest or terminal split
         ↓
6. Iterate or commit
```

## Review Keybindings

| Action | Keys | What It Does |
|--------|------|--------------|
| Next change | `]c` | Jump to next git hunk |
| Prev change | `[c` | Jump to previous hunk |
| Preview hunk | `Space h p` | Show what changed |
| Reset hunk | `Space h r` | Undo that specific change |
| Blame line | `Space h b` | Who wrote this? |
| Go to def | `gd` | Did Claude use the right thing? |
| Hover docs | `K` | Does this type make sense? |
| Find refs | `gr` | Did Claude update all usages? |

## Sending Context to Claude

### Yank File Path
```
Space y p  →  copies /full/path/to/file.py
```
Then tell Claude: "Look at [paste path]"

### Yank File:Line
```
Space y l  →  copies /full/path/to/file.py:42
```
Useful for pointing to exact locations.

### Yank Visual Selection
```
V{motion}"+y  →  copies selected code to clipboard
```
Then ask Claude: "What does this do?" or "Why is this failing?"

### Yank Error Message
```
1. Error appears in terminal
2. Visual select the traceback
3. "+y to clipboard
4. Ask Claude: "Why is this failing?"
```

## Common Prompts

### "Explain This"
```
1. Visual select confusing code
2. "+y to clipboard
3. "What does this code do?"
```

### "Fix This Error"
```
1. Yank the full traceback
2. "Why is this failing?"
3. Claude explains + suggests fix
4. Review fix with ]c / [c
```

### "Add Tests"
```
1. "Write tests for [function] in test_*.py"
2. :!pytest -v to run
3. Iterate until green
```

### "Refactor This"
```
1. "Refactor [thing] to [approach]"
2. Review each hunk with Space h p
3. Reset bad hunks with Space h r
4. Test before committing
```

## Selective Accept/Reject

Claude changed 5 things. You want to keep 4.

```
1. ]c to navigate to bad hunk
2. Space h p to confirm it's wrong
3. Space h r to reset just that hunk
4. Continue reviewing others
```

## Multi-File Changes

Claude touched multiple files:

```
1. Space f g and search for the change
   OR
2. Space f f to find files by name
3. Review each file's hunks
4. Run full test suite before commit
```

## The Refactor Workflow

```
┌─────────────────────────────────────────────┐
│ 1. Identify what needs refactoring          │
│    - Code smell, duplication, unclear       │
│                                             │
│ 2. Ask Claude specifically                  │
│    - "Extract helper function for X"        │
│    - "Rename Y to Z across the codebase"    │
│                                             │
│ 3. Review every hunk                        │
│    - Don't blindly accept                   │
│    - Check types, check usages              │
│                                             │
│ 4. Test immediately                         │
│    - :!pytest before anything else          │
│                                             │
│ 5. Commit or iterate                        │
│    - Tests pass? Commit with clear message  │
│    - Tests fail? Tell Claude, try again     │
└─────────────────────────────────────────────┘
```

## Anti-Patterns

**Don't:**
- Accept all changes without reviewing
- Skip tests ("it looks right")
- Give vague prompts ("make this better")
- Fight with Claude if it's not understanding - rephrase

**Do:**
- Review every hunk
- Test before committing
- Be specific about what you want
- Use file paths and line numbers

## Terminal Split Layout

Optimal layout for AI pair programming:

```
┌───────────────────────┬─────────────────────┐
│                       │                     │
│       Neovim          │    Claude Code      │
│      (80% width)      │    (40% width)      │
│                       │                     │
│  - Code files         │  - Conversation     │
│  - Review changes     │  - Ask questions    │
│  - Run tests          │  - Request changes  │
│                       │                     │
└───────────────────────┴─────────────────────┘
```

Open with: `Space c c` (custom :Claude command)

## Quick Test Commands

From Neovim:

```vim
:!pytest                    " Run all tests
:!pytest -v                 " Verbose
:!pytest test_models.py     " Specific file
:!pytest -k "test_add"      " Matching name
:!pytest --lf               " Last failed only
```

Or use terminal split (`Ctrl-\`) for interactive test runs.
