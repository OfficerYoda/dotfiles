#!/usr/bin/env fish

# # Define the path to your dotfiles repo.
# set -l DOTFILES_DIR "$HOME/.config"
#
# echo "Starting dotfiles sync..."
#
# # Change directory, or exit if it fails.
# # The 'cd' command in fish sets $status to non-zero on failure.
# if not cd "$DOTFILES_DIR"
#     echo "Error: Cannot change to $DOTFILES_DIR" 1>&2
#     exit 1
# end
#
# # Check for local changes.
# # 'git status --porcelain' outputs lines only if there are changes.
# set -l local_changes (git status --porcelain)
#
# if test -n "$local_changes"
#     echo "Local changes detected. Committing..."
#
#     git add -A --sparse
#
#     # Use date command to format the commit message string
#     set -l COMMIT_MSG (printf "Automatic sync: %s" (date +%Y-%m-%d\ %H:%M:%S))
#
#     git commit -m "$COMMIT_MSG"
#
#     echo "Pushing local commits..."
#     git push
# else
#     echo "No local changes detected."
# end
#
# # Pull the latest changes from the remote, using rebase to avoid merge commits
# echo "Pulling latest changes from remote (using --rebase)..."
# git pull --rebase
#
# echo "Dotfiles sync complete."
