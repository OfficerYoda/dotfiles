function compress
    if test (count $argv) -eq 0
        echo "Usage: compress <target>"
        return 1
    end

    set target (string replace -r '/$' '' "$argv[1]")
    if type -q pigz
        tar -cf - "$target" | pv -s (du -sb "$target" | awk '{print $1}') | pigz >"$target.tar.gz"
    else
        tar -cf - "$target" | pv -s (du -sb "$target" | awk '{print $1}') | gzip >"$target.tar.gz"
    end
end
