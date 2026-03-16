# Enable vi key bindings in the command line
fish_vi_key_bindings

# Disable the greeting message
set -g fish_greeting

# --- 1. ENVIRONMENT VARIABLES ---

# In Fish, 'set -x' is used for exported environment variables.
# You need to manually manage the EDITOR variable for SUDO_EDITOR.
if test -z "$EDITOR"
    set -x EDITOR nvim
end
set -x SUDO_EDITOR "$EDITOR"
set -x BAT_THEME ansi

# --- 2. INITIALIZATION ---

# Use 'status is-interactive' to check if the shell is interactive.
if status is-interactive
    # Enables fzf keygindings:
    # CTRL+R: fzf on files : Pastes the selected file/directory path onto the comman line.
    # CTRL+T: fzf on history : Fuzzy searches the command history and pastes the selected command.
    # ALT+C : fzf on directories :  Fuzzy searches directories and executes cd to the selection.
    #fzf_key_bindings
    if command -v fzf >/dev/null
        fzf --fish | source
    end

    # Mise (formerly asdf) initialization
    if command -v mise >/dev/null
        mise activate fish | source
    end

    # Starship initialization
    if command -v starship >/dev/null
        starship init fish | source
    end

    # Zoxide initialization
    if command -v zoxide >/dev/null
        # Fish uses a function (fish_add_path) to ensure paths are not duplicated
        zoxide init fish | source
    end

    # FZF completion and key-bindings
    # Fish ships with fzf completions and bindings that are usually
    # sourced automatically, but we ensure the path is set.
    # Note: Fish's fzf keybindings are generally better integrated.
    if command -v fzf >/dev/null
        # Set FZF environment variable (optional, for specific themes/behavior)
        set -x FZF_DEFAULT_OPTS "--preview 'bat --style=numbers --color=always {}'"
    end

    # Start in a tmux session inside the home directory if not already inside tmux
    if command -v tmux >/dev/null && not set -q TMUX
        if tmux has-session -t home 2>/dev/null
            tmux attach -t home
        else
            cd ~
            tmux new-session -s home
        end
    end

    # --- 3. SHELL SETTINGS (from shell) ---

    # History control: HISTSIZE and HISTFILESIZE are automatically managed by fish.
    # No need for shopt -s histappend.
    # Fish uses a flag for history ignore.
    set -g fish_history_ignore_space

    # Time in ms to wait for a KEY CODE sequence (like Escape codes) to complete
    # Setting this low fixes the "Laggy Esc" which leads to "Accidental Alt" issue
    set -g fish_escape_delay_ms 10
end

if test (uname) = Darwin # Darwin = macOS
    set -x OLLAMA_CONTEXT_LENGTH 32768
end

# --- 4. KEYBINDINGS ---

abbr --add .. "cd .."
abbr --add ... "cd ../.."
abbr --add .... "cd ../../.."

abbr --add d docker

abbr --add g git
abbr --add gcm "git commit -m"
abbr --add gcam "git commit -a -m"
abbr --add gcad "git commit -a --amend"

abbr tmls "tmux ls"

alias decompress "tar -xzf"

bind \cf _tmux-project-opener
bind \cg _tmux-session-switcher

# Created by `pipx` on 2025-12-25 03:06:32
# Modified ym `OfficerYoda` on 2026-01-06 00:57:53
set PATH $PATH $HOME/.local/bin

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
