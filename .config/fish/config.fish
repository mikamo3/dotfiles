set -Ux EDITOR nvim
set PATH ~/bin ~/.local/bin $PATH

set -Ux KAWAZU_ROOT_DIR /usr/lib/kawazu
set -Ux MEMO_DIR ~/google-drive/.memo

fish_vi_key_bindings

source ~/.config/fish/functions/fzf.fish
source /usr/lib/kawazu/kawazu.fish
starship init fish | source
