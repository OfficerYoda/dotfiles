function jr
    set -l file_path $argv[1]
    if not test -f "$file_path"
        echo "File not found: $file_path"
        return 1
    end

    # 1. Compile in place
    javac $file_path; or return 1

    # 2. Extract package and class info
    set -l package (string match -r '^package\s+(.+);' (cat $file_path | head -n 20) | tail -n 1)
    set -l class_basename (basename $file_path .java)
    set -l file_dir (dirname (realpath $file_path))

    if test -n "$package"
        # If package exists, calculate the root by going "up" 
        # based on how many segments the package has (e.g., my.pkg = 2 levels)
        set -l levels (string split "." $package)
        set -l classpath $file_dir
        for i in $levels
            set classpath (dirname $classpath)
        end
        set -l full_class_name "$package.$class_basename"

        java -cp $classpath $full_class_name
    else
        # No package: classpath is just the file's directory
        java -cp $file_dir $class_basename
    end
end
