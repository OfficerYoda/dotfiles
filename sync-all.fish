#!/usr/bin/env fish

echo "Syncing dotfiles with  chezmoi..."
./sync-chezmoi.py

echo "Syncing dotfiles with github..."
./sync-github.fish
