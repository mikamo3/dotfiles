# Fish settings
set -U fish_greeting ""
set -U fish_history_time_format "%Y-%m-%d %H:%M:%S"
set -U fish_history_size 10000
set -U fish_command_timer_enabled 1
set -U fish_command_timer_color brred
set -U fish_color_error red --bold
set -U fish_color_command green

set -Ux EDITOR nvim
set -Ux PAGER bat
set -Ux MANPAGER "sh -c 'col -bx | bat -l man -p'"
set PATH ~/bin ~/.local/bin $PATH

set -Ux KAWAZU_ROOT_DIR /usr/lib/kawazu
set -Ux MEMO_DIR ~/google-drive/.memo

fish_vi_key_bindings

# Catppuccin Mocha theme is already applied via themes directory

# fzf integration is now handled by PatrickF1/fzf.fish plugin
source /usr/lib/kawazu/kawazu.fish
source ~/.config/op/plugins.sh
starship init fish | source
zoxide init fish | source
mise activate fish | source

# Zellij auto-start (only if not already in a zellij session, not in excluded terminals, and not via SSH)
if status is-interactive; and not set -q ZELLIJ; and not string match -q "*vscode*" $TERM_PROGRAM; and not set -q SSH_CONNECTION
    exec zellij
end