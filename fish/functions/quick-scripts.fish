function quick-scripts
    # Configuration variables
    set -l scripts_dir ~/.local/bin/quick-scripts
    set -l fzf_width 55%
    set -l fzf_height 60%
    set -l fzf_header "Select script(s) to run"
    set -l close_prompt "Press any key to close..."

    set all_scripts (fd . $scripts_dir --max-depth 1 --type f --type l --extension fish --exec basename)

    set selected_scripts (printf "%s\n" $all_scripts |
        fzf-tmux -w $fzf_width -h $fzf_height --reverse --no-preview --header "$fzf_header" --multi)

    if test -n "$selected_scripts"
        # for script in $selected_scripts
        #     fish ~/.local/bin/$script
        # end
        tmux display-popup -w $fzf_width -h $fzf_height -E "fish -c '
          for script in $selected_scripts
              echo Running script \$script
              echo \n
              fish $scripts_dir/\$script
              echo \n
          end;
          read -n 1 -P \"$close_prompt\"'"
    end
end
