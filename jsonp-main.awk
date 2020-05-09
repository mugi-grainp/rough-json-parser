BEGIN {
    path = "ROOT"       # 要素へのパスを記録する
    type_path = "R"     # 要素の種類を順序付けて記録する
    prev_line = ""
    prev_key = ""
    key = ""
    array_index[0] = 0
    array_nest = 0
}

/\[/ {
    type_path = type_path "A"
    array_nest += 1
    array_index[array_nest] = 0
    path = path ".ARRAY" array_index[array_nest]
    prev_line = $0
    next
}

/\{/ {
    path = path".OBJECT"
    type_path = type_path "O"
    prev_line = $0
    next
}

/\]/ {
    sub(/.ARRAY[0-9]+$/, "", path)
    sub(/A$/, "", type_path)
    array_nest -= 1
    prev_line = $0
    next
}

/\}/ {
    n = split(path, path_array, ".")
    sub("." path_array[n], "", path)
    sub(/O$/, "", type_path)
    prev_line = $0
    next
}

/,/ {
    if (type_path == "") {
        print "Syntax Error: Invalid Comma Detected." > "/dev/stderr"
        exit
    }

    if (match(path, /ARRAY[0-9]+$/) != 0) {
        array_index[array_nest] += 1
        sub(/ARRAY[0-9]+$/, "ARRAY" array_index[array_nest], path)
    } else {
        prev_line = $0
        next
    }
    
    if (match(type_path, /O/) == 0) { prev_line = $0; next }
}

/:/  { 
    n = split(path, path_array, ".")
    prev_key = path_array[n]
    key = prev_line
    prev_line = $0
    if (prev_key != "") { sub(prev_key "$", key, path) }
    else { sub(/OBJECT$/, key, path) }
    next
}

{
    if ( (prev_line ~ /[\[:]/) || (prev_line =="," && type_path ~ /OA$/) ) {
        sub(/OBJECT$/, key, path)
        print path, $0
    }
    prev_line = $0
}

