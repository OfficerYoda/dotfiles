function quick-scripts
    set all_scripts (fd . ~/.local/bin --max-depth 1 --type f --type l --extension fish --exec basename)
    set selected_script (printf "%s\n" $all_scripts | fzf --no-preview --header "Select script to run")
    fish ~/.local/bin/$selected_script
end
