function fedit -d "Fuzzy find and edit file"
    set -l file (fd --type f | fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}')
    if test -n "$file"
        $EDITOR "$file"
    end
end