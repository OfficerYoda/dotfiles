function compress
    if test (count $argv) -eq 0
        echo "Usage: compress <target>"
        return 1
    end

    set target (string replace -r '/$' '' "$argv[1]")

    set size_kb (du -sk "$target" | cut -f1)
    set size_bytes (math "$size_kb * 1024")

    set compressor gzip
    if command -v pigz >/dev/null
        set compressor pigz
    end

    tar -cf - "$target" | pv -s $size_bytes | $compressor >"$target.tar.gz"
end
