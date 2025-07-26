#!/usr/bin/env bash
# Example init script for dotfiles - tasks removed from home role
# This script should be executed after kawazu setup to complete user environment

set -e

USER_NAME=$(whoami)
echo "Setting up environment for user: $USER_NAME"

echo "=== User Environment Setup ==="

# Setup XDG user directories with English names
echo "Setting up XDG directories with English names..."
LC_ALL=C xdg-user-dirs-update --force

# Create essential home directories
echo "Creating essential home directories..."
mkdir -p ~/Documents/{projects,notes}
mkdir -p ~/Downloads/{software,media}
mkdir -p ~/Pictures/{screenshots,wallpapers}
mkdir -p ~/.local/{bin,share/applications}

# Create source directories
echo "Creating development directories..."
mkdir -p ~/src

# Set user shell to fish
echo "Checking user shell..."
CURRENT_SHELL=$(getent passwd "$USER_NAME" | cut -d: -f7)
if [ "$CURRENT_SHELL" != "/usr/bin/fish" ]; then
    echo "Changing user shell to fish..."
    sudo chsh -s /usr/bin/fish "$USER_NAME"
else
    echo "User shell is already set to fish"
fi

# Clone dotfiles repository if needed
echo "Setting up dotfiles repository..."
if [ ! -d ~/.kawazu/dotfiles ]; then
    echo "Cloning dotfiles repository..."
    mkdir -p ~/.kawazu
    git clone https://github.com/mikamo3/dotfiles ~/.kawazu/dotfiles
else
    echo "Dotfiles repository already exists, updating..."
    cd ~/.kawazu/dotfiles
    git pull
fi

# Apply dotfiles with kawazu
echo "Applying dotfiles configuration..."
if [ -d ~/.kawazu/dotfiles ]; then
    cd ~/.kawazu/dotfiles
    # Source kawazu and apply dotfiles
    source /usr/lib/kawazu/kawazu.sh
    yes | KAWAZU_ROOT_DIR=/usr/lib/kawazu kawazu -f link
else
    echo "Error: Failed to setup dotfiles repository"
    exit 1
fi

# Application-specific setup
echo "Setting up applications..."

# Update fish plugins with fisher
if command -v fish >/dev/null 2>&1 && fish -c "functions -q fisher" >/dev/null 2>&1; then
    echo "Updating fish plugins..."
    fish -c "fisher update"
else
    echo "Skipping fish plugin setup (fisher not available)"
fi

# Install mise tools
if command -v mise >/dev/null 2>&1; then
    echo "Installing mise tools..."
    mise install
else
    echo "Skipping mise tool installation (mise not available)"
fi

echo "=== User Environment Setup Complete ==="
echo "Please log out and log back in for shell changes to take effect."