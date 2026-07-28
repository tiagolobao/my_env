#!/bin/bash

# Development Environment Configuration Installer
# This script sets up configuration files for tmux, Neovim, Kitty, and Bash

BACKUP_ENABLED=false

set -e

echo "Starting installation of development environment configurations..."

# Store current directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

show_help() {
    echo "Usage: $0 [OPTIONS]"
    echo "Options:"
    echo "  --backup    Enable backup mode"
    echo "  --help      Show this help message"
}

backup_file() {
    local file="$1"
    if [ -e "$file" ]; then
        local backup="${file}.backup.$(date +%Y%m%d_%H%M%S)"
        echo "Backing up existing $file to $backup"
        cp -r "$file" "$backup"
    fi
}

create_symlink() {
    local source="$1"
    local target="$2"
    
    if [ ! -e "$source" ]; then
        echo "Warning: Source file $source does not exist"
        return 1
    fi
    
    if [ "$BACKUP_ENABLED" = true ]; then
        backup_file "$target"
    fi
    
    # Create parent directory if it doesn't exist
    mkdir -p "$(dirname "$target")"
    
    # Remove existing symlink or file
    rm -rf "$target"
    
    # Create symlink
    ln -sf "$source" "$target"
    echo "Created symlink: $target -> $source"
}

add_to_bashrc() {
    local pattern="$1"
    local line="$2"
    local comment="$3"
    if ! grep -q "$pattern" "$HOME/.bashrc" 2>/dev/null; then
        echo "" >> "$HOME/.bashrc"
        [ -n "$comment" ] && echo "$comment" >> "$HOME/.bashrc"
        echo "$line" >> "$HOME/.bashrc"
        echo "Added '$line' to ~/.bashrc"
    else
        echo "'$line' already present in ~/.bashrc"
    fi
}

# Parse arguments
while [ $# -gt 0 ]; do
    case "$1" in
        --backup)
            BACKUP_ENABLED=true
            shift
            ;;
        --help)
            show_help
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
done

# Install tmux configuration
# Note: no plugin manager included
echo ""
echo "=== Installing tmux configuration ==="
create_symlink "$SCRIPT_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
create_symlink "$SCRIPT_DIR/tmux/plugins" "$HOME/.config/tmux/plugins"

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

# Install Git configuration
echo ""
echo "=== Installing Git configuration ==="
create_symlink "$SCRIPT_DIR/git/.gitconfig" "$HOME/.gitconfig"

# Source bash aliases in .bashrc if not already present
echo ""
echo "=== Updating .bashrc ==="
add_to_bashrc "source ~/.bash_aliases" \
    "[ -f ~/.bash_aliases ] && source ~/.bash_aliases" \
    "# Source custom bash aliases"
add_to_bashrc "export EDITOR=" "export EDITOR=nvim" "# Set default editor"

echo "=== Installation complete! ==="
