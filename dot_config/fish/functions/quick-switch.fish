function quick-scripts
    set script $(fd . ~/.local/bin --max-depth 1 --type f --type l --extension fish --exec basename)
    echo scripts | fzf --no-preview | xargs -I {} fish ~/.local/bin/{}
end
