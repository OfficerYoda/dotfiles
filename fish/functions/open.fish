function open
    if test (uname) = Darwin # Darwin = macOS
        command open $argv >/dev/null 2>/dev/null &
    else
        xdg-open $argv >/dev/null 2>/dev/null &
    end
end
