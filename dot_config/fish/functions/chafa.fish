# Wrapper for chafa to use kitty graphics protocol, with tmux passthrough if needed
function chafa --wraps chafa
    if set -q TMUX
        command chafa --format kitty --passthrough tmux $argv
    else
        command chafa --format kitty $argv
    end
end
