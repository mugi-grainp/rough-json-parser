# split-to-char.awk
# 文字単位に分割する

BEGIN {
    FS = ""
}

{
    for (i = 1; i <= NF; i++) print $i
}
