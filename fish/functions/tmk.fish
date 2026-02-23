function tmk
    set targets $argv
    set current_session (tmux display-message -p '#S' 2>/dev/null)

    # If no arguments provided, target the current session
    if not set -q targets[1]
        if test -n "$current_session"
            set targets $current_session
        else
            echo "No session specified and not currently inside a tmux session."
            return 1
        end
    end

    # If the current session is being killed, run 'tmh' first to move to home directory
    if contains -- "$current_session" $targets
        tmh
    end

    # Kill all specified sessions
    for session in $targets
        if tmux has-session -t $session 2>/dev/null
            tmux kill-session -t "$session" 2>/dev/null
            echo "Killed session: $session."
        else
            echo "Session '$session' does not exist."
        end
    end
end
