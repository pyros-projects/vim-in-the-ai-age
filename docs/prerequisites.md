# Prerequisites

What you need before starting.

## Required

### Neovim 0.9+

Neovim, not Vim. We use Lua config, native LSP, and modern plugin ecosystem.

```bash
# Check version
nvim --version

# Should show v0.9.x or higher (0.10+ preferred)
```

**Install:**

```bash
# macOS
brew install neovim

# Ubuntu/Debian (may need PPA for latest)
sudo apt install neovim

# Arch
sudo pacman -S neovim

# From source (any system)
# https://github.com/neovim/neovim/wiki/Building-Neovim
```

### Python 3.11+

We build a Python project. You need Python.

```bash
python3 --version
# Should show 3.11 or higher
```

### uv

Modern Python package manager. Fast, handles everything.

```bash
# Install
curl -LsSf https://astral.sh/uv/install.sh | sh

# Verify
uv --version
```

Don't use pip directly. Don't use poetry. Don't use conda. Just uv.

### Git

You know what git is.

```bash
git --version
```

### ripgrep

Required for telescope's live grep. Fast file content search.

```bash
# macOS
brew install ripgrep

# Ubuntu/Debian
sudo apt install ripgrep

# Arch
sudo pacman -S ripgrep

# Verify
rg --version
```

### fzf

Fuzzy finder for shell integration (Ctrl-R history, Ctrl-T files).

```bash
# macOS
brew install fzf
$(brew --prefix)/opt/fzf/install  # Install shell integration

# Ubuntu/Debian
sudo apt install fzf

# Arch
sudo pacman -S fzf

# Any system (manual)
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Verify
fzf --version
```

**Important:** Run the install script to get shell keybindings (Ctrl-R, Ctrl-T, Alt-C).

### A Terminal Emulator

Anything modern with true color support:
- **macOS:** iTerm2, Alacritty, Kitty, or built-in Terminal.app
- **Linux:** Alacritty, Kitty, GNOME Terminal, Konsole
- **Windows:** Windows Terminal (with WSL2)

If colors look wrong in Neovim, your terminal probably doesn't support true colors.

## For AI Lessons (08+)

### Claude Code

The Claude Code CLI. Required for lessons 08-10.

```bash
# Verify
claude --version
```

If you don't have it: [claude.ai/download](https://claude.ai/download)

## Optional But Recommended

### A Nerd Font

Icons in file trees and status lines need patched fonts.

Recommended: **JetBrains Mono Nerd Font** or **FiraCode Nerd Font**

Download from [nerdfonts.com](https://www.nerdfonts.com/), install, set as terminal font.

Not strictly required - things work without icons, just looks less pretty.

### tmux

Terminal multiplexer. Covered in lesson 10.

```bash
# macOS
brew install tmux

# Ubuntu/Debian
sudo apt install tmux

# Verify
tmux -V
```

## Verify Everything

Run this to check you're ready:

```bash
echo "=== Checking prerequisites ==="
echo -n "Neovim: " && nvim --version | head -1
echo -n "Python: " && python3 --version
echo -n "uv: " && uv --version
echo -n "Git: " && git --version
echo -n "ripgrep: " && rg --version | head -1
echo -n "fzf: " && fzf --version
echo "=== Done ==="
```

All green? Start with [Lesson 00](../lessons/00-setup/).

## Platform Notes

### macOS

Everything should work out of the box with Homebrew.

### Linux

Watch out for old Neovim versions in distro repos. Ubuntu especially ships ancient versions. Use the PPA or build from source.

### Windows (WSL2)

Use WSL2 with Ubuntu or similar. Native Windows Neovim exists but path handling is pain.

Run everything inside WSL. Windows Terminal as your terminal emulator.

---

Cheers, Pyro
