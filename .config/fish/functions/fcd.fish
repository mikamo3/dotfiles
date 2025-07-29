function fcd -d "Fuzzy find and change directory"
    set -l dir (fd --type d | fzf --preview 'eza --tree --level=2 --icons {}')
    if test -n "$dir"
        cd "$dir"
        eza -la --icons --git
    end
end