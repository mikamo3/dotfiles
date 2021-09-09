set -Ux EDITOR nvim
set PATH ~/bin ~/.local/bin $PATH

set -Ux KAWAZU_ROOT_DIR /usr/lib/kawazu
set -Ux MEMO_DIR ~/googleDrive/.memo

set -g theme_display_vagrant yes
set -g theme_display_nvm yes
set -g theme_display_user ssh
set -g theme_display_hostname ssh
set -g theme_display_cmd_duration yes
set -g theme_title_display_process yes
set -g theme_title_display_user yes
set -g theme_display_git_default_branch yes
set -g theme_git_default_branches master main
set -g theme_date_format "+%m/%d %H:%M"
set -g theme_avoid_ambiguous_glyphs yes
set -g theme_nerd_fonts yes
set -g theme_show_exit_status yes
set -g theme_color_scheme solarized-light
set -g theme_project_dir_length 0
set -g theme_newline_cursor yes
set -g theme_newline_prompt '>> '

fish_vi_key_bindings

source /usr/lib/kawazu/kawazu.fish
