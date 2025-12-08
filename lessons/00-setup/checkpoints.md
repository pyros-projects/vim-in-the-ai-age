# Lesson 00: Checkpoints

Verify your setup works.

## The Script

```bash
echo "=== Lesson 00 Check ==="
echo "Neovim:  $(nvim --version | head -1)"
echo "Python:  $(python3 --version 2>&1)"
echo "uv:      $(uv --version 2>/dev/null || echo 'MISSING')"
echo "ripgrep: $(rg --version | head -1 2>/dev/null || echo 'MISSING')"
echo "fzf:     $(fzf --version 2>/dev/null || echo 'MISSING')"
echo "Config:  $(test -f ~/.config/nvim/init.lua && echo 'exists' || echo 'MISSING')"
echo "=== Done ==="
```

## What You Should See

```
=== Lesson 00 Check ===
Neovim:  NVIM v0.10.x
Python:  Python 3.11.x
uv:      uv 0.x.x
ripgrep: ripgrep 14.x.x
fzf:     0.x.x
Config:  exists
=== Done ===
```

## Fixing Problems

| Shows | Problem | Fix |
|-------|---------|-----|
| NVIM v0.8.x or lower | Old version | Reinstall via PPA/Homebrew |
| Python 3.10.x or lower | Old Python | Install 3.11+ |
| MISSING (uv) | Not installed | `curl -LsSf https://astral.sh/uv/install.sh \| sh` |
| MISSING (ripgrep) | Not installed | `brew install ripgrep` or `apt install ripgrep` |
| MISSING (fzf) | Not installed | `brew install fzf` or `apt install fzf`, then run install script |
| MISSING (Config) | No init.lua | `mkdir -p ~/.config/nvim && touch ~/.config/nvim/init.lua` |

## The Real Test

Can you do this without panic?

1. Run `nvim`
2. Type `:q`
3. You're back at your terminal

Yes? You're ready for Lesson 01.

---

[Back to Lesson 00](README.md) | [Next: Lesson 01 →](../01-survival/)
