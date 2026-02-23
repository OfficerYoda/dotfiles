function _sanitize-tmux-name
    # Replace non-alphanumeric (excluding underscores) with underscores
    # Then trim underscores from both ends
    string replace -ra '[^a-zA-Z0-9_-]+' - $argv[1] | string trim -c -
end
