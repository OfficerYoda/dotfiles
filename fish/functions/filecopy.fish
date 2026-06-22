function filecopy
    if test -f "$argv[1]"
        # Get the absolute path using fish's built-in realpath helper
        set abs_path (realpath "$argv[1]")

        # Pass it to the clipboard via AppleScript
        osascript -e "set the clipboard to (posix file \"$abs_path\")"
        echo "Copied $argv[1] to clipboard."
    else
        echo "Error: File '$argv[1]' not found."
    end
end
