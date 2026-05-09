function cdll -d "change directory and list files"
  cd $argv
  command exa -la
end
