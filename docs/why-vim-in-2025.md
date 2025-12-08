# Why Vim in 2025?

You've heard the arguments against:

- "Just use VS Code, it has everything"
- "Vim is for greybeards who refuse to modernize"
- "The learning curve isn't worth it anymore"

They're wrong. Here's why Vim matters more now than ever.

## The Job Changed

AI writes more code than you do now. If you're not using Claude Code, Copilot, Cursor, or similar tools, you're working harder than you need to.

But here's the thing: **your job shifted from writing code to reviewing code.**

Claude generates 500 lines. You need to:
- Navigate quickly to understand what changed
- Jump between definitions and usages
- Find the specific hunk that looks wrong
- Fix the one thing it got wrong without touching the rest

Vim is literally optimized for this. It's a *text manipulation tool*, not a *text generation tool*. The entire keybinding system is designed around efficiently moving through and modifying existing text.

VS Code with a mouse? You're dragging a cursor around like it's 1995.

## Terminal-Native Matters

Claude Code runs in a terminal. Your tests run in a terminal. Git runs in a terminal. Your deploy scripts run in a terminal.

Why is your editor the one thing that isn't?

With Vim + tmux (or just Vim with terminal splits), everything lives in the same environment. No context switching. No "let me switch to my terminal app." You're already there.

The cognitive overhead of app-switching is real. Every time you Cmd-Tab to Terminal.app, you're paying a tax. It adds up.

## The Config-Porn Problem

Most Vim content online is terrible for learners. It's people showing off their 2000-line configs accumulated over a decade, plugins for problems you don't have, and keybindings that only make sense after years of muscle memory.

That's not learning. That's cargo-culting.

This tutorial does the opposite:
- Start with 15 lines
- Add things only when you need them
- Understand every line because you added it for a reason

By the end, you'll have ~250 lines. Not because that's the minimum, but because that's what you actually need.

## "But VS Code Has Vim Bindings"

Sure. And they're fine for basic stuff.

But you're still in VS Code's paradigm. You're still reaching for the mouse for half the operations. You don't have real terminal integration. The Vim emulation is always slightly off.

More importantly: you're not learning to think in Vim. You're just adding some keybindings to a GUI editor.

The goal isn't "use hjkl instead of arrow keys." The goal is fluency in a text-manipulation language. That only happens when you're actually in Vim.

## The AI Integration Gap

Here's the real opportunity: **nobody has figured out optimal Vim + AI workflows yet.**

The hardcore Vim community is largely anti-AI ("I write my own code"). The AI-native developers are mostly in VS Code or Cursor. The middle ground - terminal-native AI-augmented development - is underexplored.

This tutorial is partly an exploration of that space. We'll set up:
- Autoread so Claude's changes appear instantly
- Keybindings to yank context to Claude
- Git integration to review AI-generated changes hunk by hunk
- Workflows that treat Claude as a peer, not a plugin

Some of this might become standard. Some might not work. We'll find out together.

## The Actual Benefits

After going through this tutorial, you'll be able to:

1. **Navigate any codebase faster** - Jump to definitions, find usages, search patterns
2. **Edit at the speed of thought** - `ci"` to change quoted text, `.` to repeat, macros for bulk changes
3. **Review AI changes efficiently** - Hunk navigation, selective reset, inline diffs
4. **Work entirely in the terminal** - No more context switching between apps
5. **Understand what you're doing** - Not just memorized commands, but composable grammar

## The Investment

Realistically:
- **1-2 hours** to stop feeling completely lost
- **1 week** of regular use to feel comfortable
- **1 month** to stop thinking about commands consciously

That's not bad for a skill you'll use for the rest of your career.

And unlike most "productivity hacks," this one actually compounds. You get faster every month as muscle memory builds.

## Still Not Convinced?

That's fine. This tutorial will be here when you're ready.

But if you're spending hours every day in a text editor, reviewing AI-generated code, navigating large codebases - maybe the tool designed for exactly that is worth a week of your time.

---

Cheers, Pyro
