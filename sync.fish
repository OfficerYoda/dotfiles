#!/usr/bin/env fish

echo "called on timestamp"

Get timestamp
set timestamp (date '+%Y-%m-%d %H:%M:%S')

# Get callstack (function names)
set callstack (status stack-trace)

# Append to file
echo "[$timestamp] $callstack" >>called.txt

exit 0
