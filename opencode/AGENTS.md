RTK (Rust Token Killer) is active in this environment. 
Commands like `git status`, `git diff`, `ls`, and `grep` are automatically proxied via `rtk` to save context tokens.
Do NOT retry or re-run commands because of an `rtk` prefix in the command execution output.

Always use rg for searching file contents and fd for locating files. Do not use legacy grep or find if possible.
