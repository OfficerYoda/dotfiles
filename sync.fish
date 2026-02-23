#!/usr/bin/env fish

# Define the path to chezmoi dotfiles repo.
set -l DOTFILES_DIR "$HOME/.config/"

echo "Starting chezmoi sync..."

# Change directory, or exit if it fails.
if not cd "$DOTFILES_DIR"
    echo "Error: Cannot change to $DOTFILES_DIR" 1>&2
    exit 1
end

# Check for local changes.
set -l local_changes (git status --porcelain)

if test -n "$local_changes"
    echo "Local changes detected. Committing..."

    git add -A --sparse

    # Use date command to format the commit message string
    set -l COMMIT_MSG (printf "Automatic sync: %s" (date +%Y-%m-%d\ %H:%M:%S))

    git commit -m "$COMMIT_MSG"
else
    echo "No local changes detected."
end

# Pull First to integrate remote changes (replaying local commits on top)
echo "Pulling latest changes from remote (using --rebase)..."
git pull --rebase

# Push Last. If there's nothing to push
echo "Pushing commits..."
git push

echo "Dotfiles sync complete."
