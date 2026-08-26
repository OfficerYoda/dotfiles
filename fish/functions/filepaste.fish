function filepaste
    set src (osascript -e "POSIX path of (the clipboard as alias)" 2>/dev/null)
    if test -z "$src"
        echo "Error: No file in clipboard."
        return 1
    end
    set dest (test -n "$argv[1]"; and echo "$argv[1]"; or echo ".")
    cp "$src" "$dest"
    echo "Pasted $src to $dest."
end
