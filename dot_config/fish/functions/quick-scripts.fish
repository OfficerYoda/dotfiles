function quick-scripts
    set all_scripts (fd . ~/.local/bin --max-depth 1 --type f --type l --extension fish --exec basename)

    set selected_scripts (printf "%s\n" $all_scripts |
        fzf-tmux -p 55%,60% --reverse --no-preview --header "Select script(s) to run" --multi)

    if test -n "$selected_scripts"
        for script in $selected_scripts
            fish ~/.local/bin/$script
        end
    end
end
