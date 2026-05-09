#!/usr/bin/env bash
# Dotfiles initialization script for Arch Linux
# Run after ansible setup to complete user environment

set -euo pipefail

readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m'

info()    { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
warn()    { echo -e "${YELLOW}[WARN]${NC} $1"; }
error()   { echo -e "${RED}[ERROR]${NC} $1" >&2; }

trap 'error "Script failed at line $LINENO"' ERR

USER_NAME=$(whoami)
info "Setting up dotfiles environment for user: $USER_NAME"

# ---- Dependencies ----------------------------------------------------------

check_dependencies() {
    info "Checking dependencies..."
    local missing=()
    command -v git     >/dev/null 2>&1 || missing+=("git")
    command -v chezmoi >/dev/null 2>&1 || missing+=("chezmoi")

    if [[ ${#missing[@]} -gt 0 ]]; then
        error "Missing dependencies: ${missing[*]}"
        error "Please install missing packages with ansible first"
        exit 1
    fi
    success "All dependencies satisfied"
}

check_dependencies

# ---- XDG directories -------------------------------------------------------

info "Checking XDG directories..."
if grep -q 'XDG_DESKTOP_DIR.*Desktop' ~/.config/user-dirs.dirs 2>/dev/null; then
    success "XDG directories already configured in English"
else
    info "Updating XDG directories to English names..."
    LC_ALL=C xdg-user-dirs-update --force && success "XDG directories updated" || warn "Failed to update XDG directories"
fi

# ---- Home directories ------------------------------------------------------

info "Checking essential home directories..."
directories=(
    ~/Documents/projects ~/Documents/notes
    ~/Downloads/software ~/Downloads/media
    ~/Pictures/screenshots ~/Pictures/wallpapers
    ~/.local/bin ~/.local/share/applications
    ~/src
)

missing_dirs=()
for dir in "${directories[@]}"; do
    [[ -d "$dir" ]] || missing_dirs+=("$dir")
done

if [[ ${#missing_dirs[@]} -eq 0 ]]; then
    success "All home directories already exist"
else
    mkdir -p "${missing_dirs[@]}" && success "Home directories created: ${missing_dirs[*]}"
fi

# ---- Default shell ---------------------------------------------------------

info "Checking user shell..."
CURRENT_SHELL=$(getent passwd "$USER_NAME" | cut -d: -f7)
if [[ "$CURRENT_SHELL" == "/usr/bin/zsh" ]]; then
    success "User shell is already zsh"
else
    info "Changing user shell to zsh..."
    sudo chsh -s /usr/bin/zsh "$USER_NAME" && success "User shell changed to zsh"
fi

# ---- Dotfiles (chezmoi) ----------------------------------------------------

info "Applying dotfiles with chezmoi..."
if [[ ! -d ~/.kawazu/dotfiles ]]; then
    info "Cloning dotfiles repository..."
    mkdir -p ~/.kawazu
    git clone https://github.com/mikamo3/dotfiles ~/.kawazu/dotfiles
fi

chezmoi apply --source ~/.kawazu/dotfiles
success "Dotfiles applied"

# ---- zsh plugins (sheldon) -------------------------------------------------

if command -v sheldon >/dev/null 2>&1; then
    info "Installing zsh plugins with sheldon..."
    sheldon lock --update && success "Sheldon plugins installed"
else
    warn "sheldon not found, skipping plugin install"
fi

# ---- Hyprland plugins (hyprpm) ---------------------------------------------

if command -v hyprpm >/dev/null 2>&1 && command -v hyprctl >/dev/null 2>&1; then
    info "Checking Hyprland plugins..."
    if hyprpm list 2>/dev/null | grep -q "hyprexpo.*enabled"; then
        success "Hyprland plugins already installed"
    else
        hyprpm add https://github.com/hyprwm/hyprland-plugins 2>/dev/null || true
        hyprpm enable hyprexpo 2>/dev/null && hyprpm reload 2>/dev/null && success "Hyprland plugins loaded" || warn "Failed to set up Hyprland plugins"
    fi
else
    warn "Skipping Hyprland plugin setup (hyprpm/hyprctl not available)"
fi

# ---- mise ------------------------------------------------------------------

if command -v mise >/dev/null 2>&1; then
    info "Installing mise tools..."
    mise install && success "Mise tools installed" || warn "Failed to install some mise tools"
else
    warn "Skipping mise tool installation (mise not available)"
fi

success "=== Setup complete ==="
info "Please log out and log back in for shell changes to take effect."
