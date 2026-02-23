function quick-scripts
    set all_scripts (fd . ~/.local/bin --max-depth 1 --type f --type l --extension fish --exec basename)

    set selected_scripts (printf "%s\n" $all_scripts |
        fzf-tmux -w 55% -h 60% --reverse --no-preview --header "Select script(s) to run" --multi)

    if test -n "$selected_scripts"
        # for script in $selected_scripts
        #     fish ~/.local/bin/$script
        # end
        tmux display-popup -w 55% -h 60% -E "fish -c '
          for script in $selected_scripts
              echo Running script \$script
              echo \n
              fish ~/.local/bin/\$script
              echo \n
          end;
          read -n 1 -P \"Press any key to close...\"'"
    end
end
