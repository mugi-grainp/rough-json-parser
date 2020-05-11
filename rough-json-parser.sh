#!/bin/bash

# rough-json-parser.sh
# 簡易JSONパーサー
# JSON形式のテキストを，シェルスクリプトで扱いやすい
# 形に整形する．

# 入力例: [{"test1":"test", "test2":999}, {"test1": "newtest1", "test2": 888}]
# 出力例
# ROOT.ARRAY0."test1" "test"
# ROOT.ARRAY0."test2" 999
# ROOT.ARRAY1."test1" "newtest1"
# ROOT.ARRAY1."test2" 888

awk -f $(dirname $0)/split-to-char.awk |
awk -f $(dirname $0)/tokenizer.awk     |
awk -f $(dirname $0)/jsonp-main.awk

