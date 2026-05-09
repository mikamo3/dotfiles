#!/usr/bin/env bash
# User-space initialization script for Arch Linux dotfiles
# Idempotent: safe to run multiple times

set -euo pipefail

readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m'

info()    { echo -e "${BLUE}[INFO]${NC} $1"; }
ok()      { echo -e "${GREEN}[ OK ]${NC} $1"; }
skip()    { echo -e "${YELLOW}[SKIP]${NC} $1"; }
warn()    { echo -e "${YELLOW}[WARN]${NC} $1"; }
error()   { echo -e "${RED}[ERR ]${NC} $1" >&2; }

trap 'error "Failed at line $LINENO"' ERR

has() { command -v "$1" >/dev/null 2>&1; }

# ============================================================================
# 1. Prerequisite check
# ============================================================================

info "Checking prerequisites..."
missing=()
for cmd in git chezmoi zsh; do
    has "$cmd" || missing+=("$cmd")
done
if [[ ${#missing[@]} -gt 0 ]]; then
    error "Missing: ${missing[*]} — run ansible first"
    exit 1
fi
ok "Prerequisites satisfied"

# ============================================================================
# 2. XDG user directories (English names)
# ============================================================================

if grep -q 'XDG_DESKTOP_DIR.*Desktop' ~/.config/user-dirs.dirs 2>/dev/null; then
    skip "XDG directories already in English"
else
    LC_ALL=C xdg-user-dirs-update --force
    ok "XDG directories updated to English"
fi

# ============================================================================
# 3. Essential directories
# ============================================================================

dirs=(
    ~/Documents/projects
    ~/Documents/notes
    ~/Downloads/software
    ~/Downloads/media
    ~/Pictures/screenshots
    ~/Pictures/wallpapers
    ~/.local/bin
    ~/.local/share/applications
    ~/src
)
missing_dirs=()
for d in "${dirs[@]}"; do
    [[ -d "$d" ]] || missing_dirs+=("$d")
done
if [[ ${#missing_dirs[@]} -eq 0 ]]; then
    skip "All directories exist"
else
    mkdir -p "${missing_dirs[@]}"
    ok "Created: ${missing_dirs[*]}"
fi

# ============================================================================
# 4. Default shell → zsh
# ============================================================================

current_shell=$(getent passwd "$(whoami)" | cut -d: -f7)
if [[ "$current_shell" == "/usr/bin/zsh" ]]; then
    skip "Shell already zsh"
else
    sudo chsh -s /usr/bin/zsh "$(whoami)"
    ok "Shell changed to zsh (effective after re-login)"
fi

# ============================================================================
# 5. Dotfiles (chezmoi)
# ============================================================================

if [[ ! -d ~/.kawazu/dotfiles ]]; then
    info "Cloning dotfiles..."
    mkdir -p ~/.kawazu
    git clone https://github.com/mikamo3/dotfiles ~/.kawazu/dotfiles
    ok "Dotfiles cloned"
fi

chezmoi apply --source ~/.kawazu/dotfiles
ok "Dotfiles applied"

# ============================================================================
# 6. zsh plugins (sheldon)
# ============================================================================

if has sheldon; then
    # lock --update only if plugins.toml is newer than the lockfile
    lockfile="${XDG_CONFIG_HOME:-$HOME/.config}/sheldon/plugins.lock"
    plugins_toml="${XDG_CONFIG_HOME:-$HOME/.config}/sheldon/plugins.toml"
    if [[ ! -f "$lockfile" ]] || [[ "$plugins_toml" -nt "$lockfile" ]]; then
        sheldon lock --update
        ok "Sheldon plugins installed/updated"
    else
        skip "Sheldon plugins up to date"
    fi
else
    warn "sheldon not found"
fi

# ============================================================================
# 7. yazi plugins
# ============================================================================

if has ya; then
    pkg_toml="${XDG_CONFIG_HOME:-$HOME/.config}/yazi/package.toml"
    pkg_state="${XDG_STATE_HOME:-$HOME/.local/state}/yazi/packages"
    if [[ ! -d "$pkg_state" ]] || [[ "$pkg_toml" -nt "$pkg_state" ]]; then
        ya pkg install
        ok "yazi plugins installed"
    else
        skip "yazi plugins up to date"
    fi
else
    warn "ya not found"
fi

# ============================================================================
# 8. atuin history import (first time only)
# ============================================================================

if has atuin; then
    atuin_db="${XDG_DATA_HOME:-$HOME/.local/share}/atuin/history.db"
    if [[ ! -f "$atuin_db" ]]; then
        atuin import auto
        ok "atuin history imported"
    else
        skip "atuin DB already exists"
    fi
else
    warn "atuin not found"
fi

# ============================================================================
# 9. mise (runtime tools)
# ============================================================================

if has mise; then
    # mise install は未インストールのものだけ処理するので常に実行して問題なし
    mise install && ok "mise tools ready"
else
    warn "mise not found"
fi

# ============================================================================

echo ""
ok "=== Init complete ==="
if [[ "$(getent passwd "$(whoami)" | cut -d: -f7)" != "/usr/bin/zsh" ]]; then
    info "Re-login required for shell change to take effect"
fi
