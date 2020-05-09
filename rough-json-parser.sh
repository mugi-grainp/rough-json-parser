#!/bin/bash

# rough-json-parser.sh
# 簡易JSONパーサー
# JSON形式のテキストを，シェルスクリプトで扱いやすい
# 形に整形する．

# 入力例: [{"test1":"test", "test2":999}, {"test1": "newtest1", "test2": 888}]
# 出力例
# .ARRAY0."test1" "test"
# .ARRAY0."test2" 999
# .ARRAY1."test1" "newtest1"
# .ARRAY1."test2" 888


sed 's/\([[{,:]\)/\1\n/g'           | # 簡易的なトークン分割
sed 's/\([]},:]\)/\n\1/g'           | # 簡易的なトークン分割
sed 's/^[[:space:]]\+//'            |
sed 's/[[:space:]]\+$//'            |
sed '/^$/d'                         |
awk -f $(dirname $0)/jsonp-main.awk |
sed 's/^ROOT//'

