function mkcd -d "Create directory and cd into it"
    if test (count $argv) -ne 1
        echo "Usage: mkcd <directory>"
        return 1
    end
    
    mkdir -p $argv[1] && cd $argv[1]
end