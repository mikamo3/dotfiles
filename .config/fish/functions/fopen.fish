function fopen -d "Fuzzy find and open file with default application"
    set -l file (fd --type f | fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}')
    if test -n "$file"
        handlr open "$file"
    end
end