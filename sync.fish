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

# Step 2: Fetch remote
git fetch origin main
if test $status -ne 0
    echo "[$TS] ERROR: Fetch failed." >&2
    exit 1
end

# Step 3: Determine divergence and act accordingly
set -l LOCAL (git rev-parse HEAD)
set -l REMOTE (git rev-parse origin/main)
set -l BASE (git merge-base HEAD origin/main)

if test "$LOCAL" = "$REMOTE"
    echo "[$TS] Already in sync. Nothing to do."
    exit 0
else if test "$LOCAL" = "$BASE"
    # Only remote is ahead — fast-forward (no local commits at risk)
    git pull --ff-only
    if test $status -ne 0
        echo "[$TS] ERROR: Fast-forward pull failed." >&2
        exit 1
    end
    echo "[$TS] Fast-forwarded to remote."
else if test "$REMOTE" = "$BASE"
    # Only local is ahead — just push
    git push
    if test $status -ne 0
        echo "[$TS] ERROR: Push failed." >&2
        exit 1
    end
    echo "[$TS] Pushed local changes."
else
    # Both sides diverged — merge to preserve all changes
    git merge --no-edit -m "Automatic merge: $TS" origin/main
    if test $status -ne 0
        echo "[$TS] ERROR: Merge conflict. Aborting merge. Manual intervention needed." >&2
        git merge --abort 2>/dev/null
        exit 1
    end
    echo "[$TS] Merged remote changes."

    git push
    if test $status -ne 0
        echo "[$TS] ERROR: Push failed." >&2
        exit 1
    end
    echo "[$TS] Pushed merged result."
end

echo "[$TS] Sync complete."
