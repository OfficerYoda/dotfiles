#!/usr/bin/env fish

if test (uname) = Darwin
    set SCRIPT_DIR /Users/I767799/.local/share/chezmoi
    set PYTHON /Users/I767799/.local/share/mise/installs/python/3.11.14/bin/python3
    set FISH /opt/homebrew/bin/fish
else
    set SCRIPT_DIR /home/officeryoda/.local/share/chezmoi
    set PYTHON /usr/bin/python3
    set FISH /usr/bin/fish
end

echo "Syncing dotfiles with chezmoi..."
$PYTHON $SCRIPT_DIR/sync-chezmoi.py

echo "Syncing dotfiles with github..."
$FISH $SCRIPT_DIR/sync-github.fish
