# dotfiles

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/KazeTachinuu/dotfiles/master/install.sh)"
```

Clones to `~/.dotfiles` and symlinks everything into place. Idempotent,
re-run to update; existing real files are kept as `*.backup`.

| file | target |
|---|---|
| `zshrc` | `~/.zshrc` |
| `aliases.txt` | `~/.config/am/aliases.txt` |
| `starship.toml` | `~/.config/starship.toml` |
| `nvim/` | `~/.config/nvim` (LazyVim) |

The EPITA PIE environment lives in its own repo:
[epita-ing1-setup](https://github.com/KazeTachinuu/epita-ing1-setup).
