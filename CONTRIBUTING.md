# Contributing

Want to improve this tutorial? Here's how.

## What We Need

- **Bug fixes** - Typos, broken commands, outdated info
- **Platform coverage** - WSL quirks, different distros, macOS edge cases
- **Better explanations** - If something confused you, it'll confuse others
- **Exercise ideas** - More practice tasks for each lesson

## What We Don't Need

- **Alternative tool suggestions** - We're opinionated on purpose
- **Config additions** - The minimal approach is intentional
- **"Here's my 2000-line config"** - Miss the point entirely

## How to Contribute

1. Fork the repo
2. Create a branch (`fix/lesson-03-typo` or `improve/exercise-clarity`)
3. Make your changes
4. Test on a fresh Neovim install if possible
5. Submit a PR with a clear description

## Writing Style

Match the existing tone:

- Direct, no fluff
- Assume the reader is intelligent
- Show, don't tell
- Every sentence should carry weight

**Don't:**
- Add hedging ("you might want to consider...")
- Over-explain basics
- Use corporate speak
- Pad word count

## Lesson Structure

If adding or modifying lessons, follow the template:

```markdown
# Lesson N: Title

## What You'll Learn
## Prerequisites
## Context (why we need this NOW)
## The Lesson (step by step)
## New Keybindings Summary
## Practice Exercises
## Checkpoint
## Common Issues
## Config Changes
```

## Testing Changes

Before submitting:

1. Start with a fresh Neovim install (or `nvim -u NONE`)
2. Follow the lesson from scratch
3. Verify all commands work
4. Check config at each stage compiles

## Questions?

Open an issue. Keep it specific.
