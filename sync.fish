#!/usr/bin/env fish

set -l DOTFILES_DIR "$HOME/.config"
set -l TS (date '+%Y-%m-%d %H:%M:%S')

echo "[$TS] Sync starting..."

cd "$DOTFILES_DIR"; or begin
    echo "[$TS] ERROR: Cannot cd to $DOTFILES_DIR" >&2
    exit 1
end

# Guard: bail if a rebase/merge is already in progress
if test -d .git/rebase-merge; or test -d .git/rebase-apply; or test -f .git/MERGE_HEAD
    echo "[$TS] ERROR: Rebase or merge already in progress. Skipping." >&2
    exit 1
end

# Step 1: Commit local changes (if any)
set -l changes (git status --porcelain)
if test -n "$changes"
    git add -A
    git commit -m "Automatic sync: $TS"
    if test $status -ne 0
        echo "[$TS] ERROR: Commit failed." >&2
        exit 1
    end
    echo "[$TS] Committed local changes."
else
    echo "[$TS] No local changes."
end

# Step 2: Pull with rebase
git pull --rebase
if test $status -ne 0
    echo "[$TS] ERROR: Pull --rebase failed. Aborting rebase." >&2
    git rebase --abort 2>/dev/null
    exit 1
end
echo "[$TS] Pull complete."

# Step 3: Push
git push
if test $status -ne 0
    echo "[$TS] ERROR: Push failed." >&2
    exit 1
end

echo "[$TS] Sync complete."
