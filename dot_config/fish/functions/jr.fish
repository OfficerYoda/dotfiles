function jr
    # 1. Extract the file path
    set file_path $argv[1]

    # 2. Compile the file
    javac $file_path
    if test $status -ne 0
        return 1
    end

    # 3. Determine the package/class name and classpath
    # This assumes your source is in src/main/java/
    set class_path app/src/main/java

    # Strip the path prefix and the .java extension
    set class_name (string replace -r "^$class_path/" "" $file_path | string replace ".java" "" | string replace -a "/" ".")

    # 4. Run the class
    java -cp $class_path $class_name
end
