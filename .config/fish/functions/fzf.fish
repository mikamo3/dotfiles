function killf
  set id (ps -ef | sed 1d | fzf -m | awk '{print $2}')
  if test $status -eq 0
    kill -9 $id
  end
end