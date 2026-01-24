function tma
    set session $argv[1]
    set flags $argv[2..-1]

    if set -q TMUX
        # Switch if already inside tmux
        tmux switch-client -t $session $flags
    else
        # Attach if outside tmux
        tmux attach -t $session $flags
    end
end
