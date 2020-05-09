# rough-json-parser: 簡易JSONパーサー

JSON形式のテキストを，シェルスクリプトで扱いやすい
形に整形する．

入力例

    [{"test1":"test", "test2":999}, {"test1": "newtest1", "test2": 888}]

出力例

    .ARRAY0."test1" "test"
    .ARRAY0."test2" 999
    .ARRAY1."test1" "newtest1"
    .ARRAY1."test2" 888

## Usage

    echo '[{"test1":"test", "test2":999}, {"test1": "newtest1", "test2": 888}]' | rough-json-parser.sh

## 注意
- 入力されるJSONに対する妥当性検査は一切していません．
- 不正なJSON入力に対する出力は未定義です．
- 一部JSONにはまだ対応できていません．
