function _tmux-project-opener
    set home_path $HOME
    set dev_path $HOME/dev
    set config_path $HOME/.config
    set documents_path $HOME/Documents
    set chezmoi_path $HOME/.local/share/

    # 'begin; ...; end' groups the output of multiple commands
    set selected (begin
        echo $config_path
        # -L follows symlinks
        fd -L --min-depth 1 --max-depth 1 --type d . $config_path
        fd -L --min-depth 1 --max-depth 2 --type d . $dev_path
        fd -L --min-depth 1 --max-depth 1 --type d . $home_path
        fd -L --min-depth 1 --max-depth 2 --type d . $documents_path
        fd -L --min-depth 1 --max-depth 1 --type d . $chezmoi_path
    end | fzf-tmux -p 55%,60% --reverse --no-preview --header "Enter: Open Project in Tmux Session")

    if test -n "$selected"
        # Create valid session name by replacing non-alphanumeric characters with underscores
        set session_name (_sanitize-tmux-name (basename "$selected"))

        # Create session if it doesn't exist
        if not tmux has-session -t "$session_name" 2>/dev/null
            tmux new-session -d -s "$session_name" -c "$selected"
        end

        # Switch or Attach
        if set -q TMUX
            tmux switch-client -t "$session_name"
        else
            tmux attach -t "$session_name"
        end
    end
    commandline -f repaint
end
