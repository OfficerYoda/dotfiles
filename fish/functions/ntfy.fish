function ntfy --description "Publish a message to ntfy"
    if test (count $argv) -lt 2
        echo "Usage: ntfy TOPIC MESSAGE..." >&2
        return 2
    end

    set -l topic $argv[1]
    set -l message (string join ' ' -- $argv[2..-1])

    command curl --fail --silent --show-error --data "$message" "https://ntfy.officeryoda.dev/$topic"
    and echo "Sent to $topic."
end
