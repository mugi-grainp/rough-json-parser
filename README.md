# rough-json-parser: 簡易JSONパーサー

JSON形式のテキストを，シェルスクリプトで扱いやすい
形に整形する．

入力例

    [{"test1":"test", "test2":999}, {"test1": "newtest1", "test2": 888}]

出力例

    ROOT.ARRAY0."test1" "test"
    ROOT.ARRAY0."test2" 999
    ROOT.ARRAY1."test1" "newtest1"
    ROOT.ARRAY1."test2" 888

## Usage

    echo '[{"test1":"test", "test2":999}, {"test1": "newtest1", "test2": 888}]' | rough-json-parser.sh

## TODO
- ~~まともなトークン分割プログラムを作ります．~~
    - ~~トークン分割が簡易的（というよりかなり乱暴）なため，たとえばURLが崩壊します．~~

世界の ~~半分~~ 80パーセントくらいのJSONは処理できるようになったと思います．

## 注意
- 入力されるJSONに対する妥当性検査は一切していません．
- 不正なJSON入力に対する出力は未定義です．
- 一部（大半？）のJSONにはまだ対応できていません．
