# Environment variables for better tool integration
set -Ux FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border --ansi --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8,fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc,marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8'
set -Ux FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
set -Ux FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND

# Ripgrep configuration
set -Ux RIPGREP_CONFIG_PATH ~/.config/ripgrep/ripgreprc

# Bat configuration for Catppuccin theme
set -Ux BAT_THEME "Catppuccin-mocha"

# Delta configuration for git diff
set -Ux DELTA_FEATURES '+side-by-side'