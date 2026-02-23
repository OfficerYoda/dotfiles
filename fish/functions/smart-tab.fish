# Thanks to mario-holubar on github: https://github.com/fish-shell/fish-shell/issues/3011#issuecomment-3360970087
# Tab once to accept suggestion, twice to trigger completion menu
function smart-tab
    # 1. If in the completion menu, just navigate
    if commandline --paging-mode
        commandline -f complete
        return
    end

    set -l current (commandline)

    # 2. If the line has changed since the last tab, try to accept suggestion
    if test "$current" != "$__smart_tab_last"
        set -g __smart_tab_prev "$current"
        commandline -f accept-autosuggestion
        set -g __smart_tab_last (commandline)

        # If accepting the suggestion changed nothing, trigger completion menu
        if test (commandline) = "$current"
            commandline -f complete
        end

        # 3. Second tab detected: revert to original text and show menu
    else
        commandline -r "$__smart_tab_prev"
        commandline -f complete
    end
end
