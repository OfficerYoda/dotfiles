function tmh
    if tmux has-session -t home 2>/dev/null
        tma home
    else
        fish -c 'cd ~; tmc home'
    end
end
