function tmc
    set session_name $argv[1]
    set flags $argv[2..-1]

    if test -z "$session_name"
        # Create valid session name by replacing non-alphanumeric characters with underscores
        set folder_name (basename (pwd))
        set session_name (_sanitize-tmux-name "$folder_name")
    end

    # Create if not a session already exists with same name | PATH NOT CONSIDERED
    if not tmux has-session -t "$session_name" 2>/dev/null
        tmux new -d -s "$session_name" $flags
    end

    # Attach or switch to the session when not created detached
    if not contains -- -d $flags
        tma $session_name
    end
end
