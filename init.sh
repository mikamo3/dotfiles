#!/usr/bin/env bash
# Dotfiles initialization script for Arch Linux
# This script should be executed after ansible setup to complete user environment

set -euo pipefail  # Stricter error handling

# Colors for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m' # No Color

# Logging functions
info() { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1" >&2; }

# Error handler
error_exit() {
    error "Script failed at line $1"
    exit 1
}
trap 'error_exit $LINENO' ERR

USER_NAME=$(whoami)
info "Setting up dotfiles environment for user: $USER_NAME"

echo "=== Dotfiles Environment Setup ==="

# Check dependencies
check_dependencies() {
    info "Checking dependencies..."
    local missing_deps=()
    
    # Essential tools
    command -v git >/dev/null 2>&1 || missing_deps+=("git")
    command -v fish >/dev/null 2>&1 || missing_deps+=("fish")
    
    # kawazu specific
    if [[ ! -f /usr/lib/kawazu/kawazu.sh ]]; then
        missing_deps+=("kawazu")
    fi
    
    if [[ ${#missing_deps[@]} -gt 0 ]]; then
        error "Missing dependencies: ${missing_deps[*]}"
        error "Please install missing packages with ansible first"
        exit 1
    fi
    
    success "All dependencies satisfied"
}

check_dependencies

# Setup XDG user directories with English names
info "Checking XDG directories..."
# Check if XDG directories are already in English
if [[ -f ~/.config/user-dirs.dirs ]]; then
    # Check if already configured (look for Desktop instead of デスクトップ)
    if grep -q 'XDG_DESKTOP_DIR.*Desktop' ~/.config/user-dirs.dirs 2>/dev/null; then
        success "XDG directories already configured in English"
    else
        info "Updating XDG directories to English names..."
        if LC_ALL=C xdg-user-dirs-update --force; then
            success "XDG directories updated to English"
        else
            warn "Failed to update XDG directories, continuing..."
        fi
    fi
else
    info "Setting up XDG directories with English names..."
    if LC_ALL=C xdg-user-dirs-update --force; then
        success "XDG directories created in English"
    else
        warn "Failed to create XDG directories, continuing..."
    fi
fi

# Create essential home directories
info "Checking essential home directories..."
directories=(
    ~/Documents/projects ~/Documents/notes
    ~/Downloads/software ~/Downloads/media
    ~/Pictures/screenshots ~/Pictures/wallpapers
    ~/.local/bin ~/.local/share/applications
    ~/src
    ~/google-drive
)

missing_dirs=()
for dir in "${directories[@]}"; do
    if [[ ! -d "$dir" ]]; then
        missing_dirs+=("$dir")
    fi
done

if [[ ${#missing_dirs[@]} -eq 0 ]]; then
    success "All home directories already exist"
else
    info "Creating missing directories: ${missing_dirs[*]}"
    if mkdir -p "${missing_dirs[@]}"; then
        success "Missing home directories created"
    else
        error "Failed to create home directories"
        exit 1
    fi
fi

# Set user shell to fish
info "Checking user shell..."
CURRENT_SHELL=$(getent passwd "$USER_NAME" | cut -d: -f7)
if [[ "$CURRENT_SHELL" != "/usr/bin/fish" ]]; then
    info "Changing user shell to fish..."
    if sudo chsh -s /usr/bin/fish "$USER_NAME"; then
        success "User shell changed to fish"
    else
        error "Failed to change shell to fish"
        exit 1
    fi
else
    success "User shell is already set to fish"
fi

# Clone dotfiles repository if needed
info "Checking dotfiles repository..."
if [[ ! -d ~/.kawazu/dotfiles ]]; then
    info "Cloning dotfiles repository..."
    mkdir -p ~/.kawazu
    if git clone https://github.com/mikamo3/dotfiles ~/.kawazu/dotfiles; then
        success "Dotfiles repository cloned"
    else
        error "Failed to clone dotfiles repository"
        exit 1
    fi
else
    # Check if repository needs updating
    if (cd ~/.kawazu/dotfiles && git fetch --dry-run &>/dev/null); then
        if (cd ~/.kawazu/dotfiles && [[ $(git rev-list HEAD...@{u} --count 2>/dev/null) -gt 0 ]]); then
            info "Dotfiles repository has updates, pulling..."
            if (cd ~/.kawazu/dotfiles && git pull); then
                success "Dotfiles repository updated"
            else
                warn "Failed to update dotfiles repository, continuing with existing version..."
            fi
        else
            success "Dotfiles repository already up to date"
        fi
    else
        success "Dotfiles repository exists (offline mode)"
    fi
fi

# Apply dotfiles with kawazu  
info "Checking dotfiles configuration..."
if [[ -d ~/.kawazu/dotfiles ]]; then
    # Check if kawazu links need updating (simple heuristic: check if a key symlink exists)
    key_files=(
        ~/.config/fish/config.fish
        ~/.config/starship.toml
        ~/.gitconfig
    )
    
    needs_update=false
    for file in "${key_files[@]}"; do
        if [[ ! -L "$file" ]] || [[ ! -e "$file" ]]; then
            needs_update=true
            break
        fi
    done
    
    if [[ "$needs_update" == true ]]; then
        info "Applying dotfiles configuration..."
        if (cd ~/.kawazu/dotfiles && source /usr/lib/kawazu/kawazu.sh && yes | KAWAZU_ROOT_DIR=/usr/lib/kawazu kawazu -f link); then
            success "Dotfiles applied successfully"
        else
            error "Failed to apply dotfiles with kawazu"
            exit 1
        fi
    else
        success "Dotfiles configuration already applied"
    fi
else
    error "Dotfiles repository not found"
    exit 1
fi

# Application-specific setup
info "Setting up applications..."

# Setup Hyprland plugins with hyprpm
if command -v hyprpm >/dev/null 2>&1 && command -v hyprctl >/dev/null 2>&1; then
    info "Checking Hyprland plugins..."
    
    # Check if hyprexpo plugin is already installed
    if hyprpm list 2>/dev/null | grep -q "hyprexpo.*enabled"; then
        success "Hyprland plugins already installed and enabled"
    else
        info "Installing Hyprland plugins..."
        
        # Add plugin repository if not exists
        if ! hyprpm list 2>/dev/null | grep -q "hyprland-plugins"; then
            info "Adding hyprland-plugins repository..."
            if hyprpm add https://github.com/hyprwm/hyprland-plugins; then
                success "Plugin repository added"
            else
                warn "Failed to add plugin repository"
            fi
        fi
        
        # Enable hyprexpo plugin
        if hyprpm enable hyprexpo 2>/dev/null; then
            info "Hyprexpo plugin enabled"
        else
            warn "Failed to enable hyprexpo plugin"
        fi
        
        # Reload plugins
        if hyprpm reload 2>/dev/null; then
            success "Hyprland plugins loaded successfully"
        else
            warn "Failed to reload Hyprland plugins"
        fi
    fi
else
    warn "Skipping Hyprland plugin setup (hyprpm/hyprctl not available)"
fi

# Update fish plugins with fisher
if command -v fish >/dev/null 2>&1 && fish -c "functions -q fisher" >/dev/null 2>&1; then
    info "Checking fish plugins..."
    # Simple check: if fish_plugins file exists and is readable, assume plugins are set up
    if [[ -f ~/.config/fish/fish_plugins ]] && [[ -s ~/.config/fish/fish_plugins ]]; then
        # Check if plugins are actually installed by testing a common one
        if fish -c "functions -q tide" >/dev/null 2>&1 || fish -c "functions -q starship" >/dev/null 2>&1; then
            success "Fish plugins already installed"
        else
            info "Installing fish plugins..."
            if fish -c "fisher update"; then
                success "Fish plugins installed"
            else
                warn "Failed to install fish plugins"
            fi
        fi
    else
        info "Installing fish plugins..."
        if fish -c "fisher update"; then
            success "Fish plugins installed"
        else
            warn "Failed to install fish plugins"
        fi
    fi
else
    warn "Skipping fish plugin setup (fisher not available)"
fi

# Install mise tools
if command -v mise >/dev/null 2>&1; then
    info "Checking mise tools..."
    # Check if .tool-versions file exists and tools are installed
    if [[ -f ~/.tool-versions ]] || [[ -f ~/.kawazu/dotfiles/.tool-versions ]]; then
        # Check if mise tools are already installed by running mise list
        if mise list &>/dev/null && [[ $(mise list | wc -l) -gt 0 ]]; then
            success "Mise tools already installed"
        else
            info "Installing mise tools..."
            if mise install; then
                success "Mise tools installed"
            else
                warn "Failed to install some mise tools"
            fi
        fi
    else
        info "No .tool-versions file found, skipping mise installation"
    fi
else
    warn "Skipping mise tool installation (mise not available)"
fi

success "=== Dotfiles Environment Setup Complete ==="
info "Please log out and log back in for shell changes to take effect."