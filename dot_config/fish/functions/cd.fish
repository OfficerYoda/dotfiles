function cd
    if test (count $argv) -eq 0
        builtin cd ~
        return
    else if test -d "$argv[1]"
        builtin cd "$argv[1]"
        return
    else
        # The z command must be installed and initialized (via zoxide init)
        z "$argv"
        if test $status -eq 0
            printf "\U000F17A9 " # Print the success icon from your Bash script
            pwd
        else
            echo "Error: Directory not found"
        end
        return
    end
end
