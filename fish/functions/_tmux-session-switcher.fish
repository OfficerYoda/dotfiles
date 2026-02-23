function _tmux-session-switcher
    # 1. --multi: Allows selecting multiple sessions with TAB
    # 2. --bind 'ctrl-x': Kills selected sessions and reloads the list
    set session (tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf-tmux -p 55%,60% \
        --reverse \
        --multi \
        --preview="" \
        --header "Enter: Switch | Ctrl-X: Kill Session(s)" \
        --bind "ctrl-x:execute(tmk {+})+reload(tmux list-sessions -F '#{session_name}')")

    if test -n "$session"
        if set -q TMUX
            tmux switch-client -t "$session"
        else
            tmux attach -t "$session"
        end
    end
    commandline -f repaint
end
