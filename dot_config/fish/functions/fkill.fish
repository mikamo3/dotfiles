function fkill -d "Fuzzy find and kill process"
    set -l pid (procs | tail -n +2 | fzf --multi --preview-window=:hidden | awk '{print $1}')
    if test -n "$pid"
        for p in $pid
            kill -9 $p
            echo "Killed process $p"
        end
    end
end