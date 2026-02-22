# Development Environment Configuration

This repository contains customized configuration files for:

- **tmux** – terminal multiplexer configuration
- **Neovim (nvim)** – modern Vim-based text editor setup
- **Kitty** – GPU‑accelerated terminal emulator
- **Bash** – shell environment and aliases

## Purpose

These configurations are tailored to provide a productive, consistent, and visually pleasing development experience across different tools and terminals.

## Structure

- `tmux/` – tmux configuration files (`.tmux.conf`, themes, plugins)
- `nvim/` – Neovim configuration (init.lua, plugin specs, keymaps)
- `kitty/` – Kitty terminal configuration (kitty.conf, themes)
- `bash/` – Bash startup scripts (`.bashrc`, `.bash_profile`, aliases)
- `install.sh` – Installation script for Linux environments
- `.aider.conf.yml` – Configuration for Aider AI coding assistant

## Quick Start

1. Clone this repository.
2. Run the installation script: `./install.sh`
3. The script will create symlinks for each configuration to their appropriate locations.

> **Note:** Always back up your existing configuration files before replacing them.

### Manual Installation

If you prefer to install configurations individually:

```bash
# tmux
ln -sf $(pwd)/tmux/.tmux.conf ~/.tmux.conf

# Neovim
mkdir -p ~/.config/nvim
ln -sf $(pwd)/nvim/init.lua ~/.config/nvim/init.lua

# Kitty
mkdir -p ~/.config/kitty
ln -sf $(pwd)/kitty/kitty.conf ~/.config/kitty/kitty.conf

# Bash
ln -sf $(pwd)/bash/.bash_aliases ~/.bash_aliases
```

> Of course you can copy the files as well

## License

See the [LICENSE](LICENSE) file for terms and conditions (if present).
