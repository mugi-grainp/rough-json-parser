# tokenizer.awk
# JSONのトークン分割を行う．

# 簡易トークン分割実装の置き換え
# sed 's/\([[{,:]\)/\1\n/g'           | # 簡易的なトークン分割
# sed 's/\([]},:]\)/\n\1/g'           | # 簡易的なトークン分割

# 入力
# 1文字単位に分割されたJSON
# 出力
# トークン

BEGIN {
    FS = ""

    in_the_string = 0
    escaped_char  = 0
    in_the_num_token = 0

    token = ""
}

/\\/ {
    token = token $0
    if (escaped_char) {
        escaped_char = 0
    } else {
        escaped_char = 1
    }
    next
}

/"/ {
    token = token $0
    if (escaped_char) {
        escaped_char = 0
    } else if (in_the_string) {
        print token
        token = ""
        in_the_string = 0
    } else {
        in_the_string = 1
    }
    next
}

/[\[\{:]/ {
    print
    next
}

/[\]\}]/ {
    if (in_the_num_token) {
        print token
        token = ""
    }
    print
    next
}

/,/ {
    if ((token ~ /(true|false|null)/) || in_the_num_token) {
        print token
        token = ""
    }
    print
    next
}

/[[:space:]]/ {
    if (in_the_string) {
        token = token $0
    }
    next
}

/[0-9]/ {
    if (in_the_string == 0) {
        in_the_num_token = 1
    }
    token = token $0
    next
}

{
    token = token $0
}

