function flog -d "Interactive git log browser with preview"
    git log --oneline --color=always | fzf --ansi --preview 'git show --color=always {1}' --bind 'enter:execute(git show {1} | bat --language=diff)'
end