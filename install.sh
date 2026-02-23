#!/bin/bash

# Development Environment Configuration Installer
# This script sets up configuration files for tmux, Neovim, Kitty, and Bash

set -e

echo "Starting installation of development environment configurations..."

# Store current directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Function to create backup of existing file
backup_file() {
    local file="$1"
    if [ -e "$file" ]; then
        local backup="${file}.backup.$(date +%Y%m%d_%H%M%S)"
        echo "Backing up existing $file to $backup"
        cp -r "$file" "$backup"
    fi
}

# Function to create symlink
create_symlink() {
    local source="$1"
    local target="$2"
    
    if [ ! -e "$source" ]; then
        echo "Warning: Source file $source does not exist"
        return 1
    fi
    
    backup_file "$target"
    
    # Create parent directory if it doesn't exist
    mkdir -p "$(dirname "$target")"
    
    # Remove existing symlink or file
    rm -rf "$target"
    
    # Create symlink
    ln -sf "$source" "$target"
    echo "Created symlink: $target -> $source"
}

# Install tmux configuration
echo ""
echo "=== Installing tmux configuration ==="
create_symlink "$SCRIPT_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"

# Install Neovim configuration
echo ""
echo "=== Installing Neovim configuration ==="
create_symlink "$SCRIPT_DIR/nvim" "$HOME/.config/nvim"

# Install Kitty configuration
echo ""
echo "=== Installing Kitty configuration ==="
create_symlink "$SCRIPT_DIR/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"

# Install Bash aliases
echo ""
echo "=== Installing Bash aliases ==="
create_symlink "$SCRIPT_DIR/bash/.bash_aliases" "$HOME/.bash_aliases"

# Install Aider configuration
# echo ""
# echo "=== Installing Aider configuration ==="
# create_symlink "$SCRIPT_DIR/.aider.conf.yml" "$HOME/.aider.conf.yml"

# Install Git configuration
echo ""
echo "=== Installing Git configuration ==="
create_symlink "$SCRIPT_DIR/git/.gitconfig" "$HOME/.gitconfig"

# Source bash aliases in .bashrc if not already present
echo ""
echo "=== Updating .bashrc ==="
BASH_ALIASES_SOURCE="[ -f ~/.bash_aliases ] && source ~/.bash_aliases"
if ! grep -q "source ~/.bash_aliases" "$HOME/.bashrc" 2>/dev/null; then
    echo "" >> "$HOME/.bashrc"
    echo "# Source custom bash aliases" >> "$HOME/.bashrc"
    echo "$BASH_ALIASES_SOURCE" >> "$HOME/.bashrc"
    echo "Added bash aliases sourcing to ~/.bashrc"
else
    echo "Bash aliases sourcing already present in ~/.bashrc"
fi

echo "=== Installation complete! ==="
