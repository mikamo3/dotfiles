# dotfiles

Personal dotfiles repository for a Linux development environment with Wayland support.

## 🚀 Quick Start

```bash
# Clone the repository
git clone https://github.com/mikamo3/dotfiles ~/dotfiles

# Create symbolic links to configuration files
ln -sf ~/dotfiles/.config/* ~/.config/
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig

# Run the environment setup script
cd ~/dotfiles
./init.sh
```

After setup, log out and log back in for shell changes to take effect.

## 📦 What's Included

### Core Tools
- **Shell**: [Fish](https://fishshell.com/) - User-friendly command line shell
- **Terminal**: [Kitty](https://sw.kovidgoyal.net/kitty/) - GPU-accelerated terminal emulator
- **Editor**: [Neovim](https://neovim.io/) - Modern Vim-based editor
- **Multiplexer**: [Tmux](https://github.com/tmux/tmux) & [Zellij](https://zellij.dev/) - Terminal session management

### Window Management (Wayland)
- **Compositor**: [Sway](https://swaywm.org/) & [Hyprland](https://hyprland.org/) - Wayland window managers
- **Status Bar**: [Waybar](https://github.com/Alexays/Waybar) - Highly customizable status bar
- **Launcher**: [Rofi](https://github.com/davatorium/rofi) - Application launcher and window switcher
- **Notifications**: [Mako](https://github.com/emersion/mako) - Lightweight notification daemon

### Development Environment
- **Version Manager**: [mise](https://mise.jdx.dev/) - Runtime version management
- **Prompt**: [Starship](https://starship.rs/) - Cross-shell prompt
- **Git Configuration**: Enhanced git aliases and configurations
- **Font Configuration**: Optimized font settings for development

## 📁 Directory Structure

```
~/dotfiles/
├── .config/                    # Application configurations (→ ~/.config/)
│   ├── fish/                   # Fish shell configuration
│   ├── nvim/                   # Neovim configuration
│   ├── kitty/                  # Kitty terminal configuration
│   ├── sway/                   # Sway window manager
│   ├── hypr/                   # Hyprland configuration
│   ├── waybar/                 # Status bar configuration
│   ├── rofi/                   # Application launcher
│   ├── tmux/                   # Tmux configuration
│   ├── zellij/                 # Zellij configuration
│   ├── mako/                   # Notification daemon
│   ├── mise/                   # Runtime version manager
│   └── starship.toml           # Shell prompt configuration
├── .local/                     # Local user data (→ ~/.local/)
├── .ssh/                       # SSH configuration (→ ~/.ssh/)
├── .gitconfig                  # Git global configuration (→ ~/.gitconfig)
├── init.sh                     # Environment setup script
└── README.md                   # This file
```

## 🛠️ Installation

### Method 1: Manual Installation
```bash
# Clone the repository
git clone https://github.com/mikamo3/dotfiles ~/dotfiles
cd ~/dotfiles

# Create symbolic links for configuration directories
ln -sf ~/dotfiles/.config/* ~/.config/

# Create symbolic links for home directory files
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
# Add other root-level dotfiles as needed:
# ln -sf ~/dotfiles/.bashrc ~/.bashrc
# ln -sf ~/dotfiles/.vimrc ~/.vimrc

# Run environment setup
./init.sh
```

### Method 2: Using GNU Stow
```bash
git clone https://github.com/mikamo3/dotfiles ~/dotfiles
cd ~/dotfiles
stow . --target=~
```

### Method 3: Using Other Dotfiles Managers
You can also use managers like [chezmoi](https://www.chezmoi.io/), [yadm](https://yadm.io/), or any other tool of your choice.

## 🎨 Features

### Fish Shell
- Enhanced autocompletion and syntax highlighting
- Custom functions and aliases
- Plugin management with Fisher

### Window Management
- Tiling window managers (Sway/Hyprland) with Wayland support
- Custom keybindings for efficient workflow
- Multi-monitor support with Kanshi

### Development Environment
- Git aliases and enhanced configuration
- Runtime version management with mise
- Consistent terminal and editor themes

### Visual Consistency
- Unified color schemes across applications
- Nerd Font support for icons
- Customized status bars and notifications

## 🔧 Customization

### Key Configuration Files
- **Shell prompt**: `.config/starship.toml`
- **Terminal**: `.config/kitty/kitty.conf` 
- **Window manager**: `.config/sway/config` or `.config/hypr/hyprland.conf`
- **Status bar**: `.config/waybar/config.jsonc`
- **Git**: `.gitconfig`

### Adding New Configurations
1. Add configuration files to the appropriate directory structure
2. Update installation instructions to include new symlinks if needed
3. Document changes in this README

## 📋 Dependencies

### Required
- Git
- Fish shell
- Basic UNIX tools (ln, mkdir, etc.)

### Optional (for full functionality)
- Wayland compositor (Sway or Hyprland)
- Kitty terminal emulator
- Neovim  
- mise (runtime version manager)
- Tmux or Zellij
- Waybar, Rofi, Mako (for Wayland desktop)

## 🤝 Usage Notes

This repository contains my personal configurations optimized for:
- Arch Linux environment
- Wayland-based desktop
- Development workflows  
- Japanese input support (Fcitx5)

Feel free to fork and adapt these configurations for your own use.

## 📄 License

See [LICENSE](LICENSE) file for details.
